import React, { useState, useEffect } from "react";
import axios from "axios";

export default function AdminDashboard() {
  const [loggedIn, setLoggedIn] = useState(false);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [authLoading, setAuthLoading] = useState(false);

  const [activeTable, setActiveTable] = useState("trusted-senders");
  const [data, setData] = useState([]);
  const [loadingTable, setLoadingTable] = useState(false);
  const [error, setError] = useState("");

  const API_BASE = "http://localhost:8000";

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");
    setAuthLoading(true);
    try {
      
      const res = await axios.post(`${API_BASE}/auth/login`, { username, password });
      if (res.status === 200) setLoggedIn(true);
      else setError("بيانات الدخول غير صحيحة");
    } catch {
      setError("تعذر الاتصال بالسيرفر أو بيانات غير صحيحة");
    } finally {
      setAuthLoading(false);
    }
  };

  const fetchTable = async (table) => {
    setLoadingTable(true);
    setError("");
    try {
      const { data } = await axios.get(`${API_BASE}/db/${table}`);
      setData(data.rows || []);
    } catch {
      setError("حصل خطأ أثناء جلب البيانات");
      setData([]);
    } finally {
      setLoadingTable(false);
    }
  };

  useEffect(() => {
    if (loggedIn) fetchTable(activeTable);
    // eslint-disable-next-line
  }, [loggedIn, activeTable]);

 
  if (!loggedIn) {
    const logoClass = `auth-logo logo-glow ${authLoading ? "logo-spin" : ""}`;
    return (
      <div className="admin-wrap rtl">
        <div className="auth-card glass">
          <div className="auth-head">
            <div className={logoClass}>
             
              <img src="/logo.png" alt="AMAN AI Logo" />
            </div>
            <h2>تسجيل دخول الأدمن</h2>
            <p>دخول آمن لإدارة البيانات (قراءة فقط حاليًا)</p>
          </div>

          <form onSubmit={handleLogin} className="auth-form">
            <div className="field">
              <label>اسم المستخدم</label>
              <input
                className="input"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                placeholder="مثال: admin"
                required
                disabled={authLoading}
              />
            </div>

            <div className="field">
              <label>كلمة المرور</label>
              <input
                type="password"
                className="input"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                required
                disabled={authLoading}
              />
            </div>

            {error && <div className="alert error">{error}</div>}

            <button type="submit" className="btn btn-primary full" disabled={authLoading}>
              {authLoading ? "جارٍ التحقق..." : "دخول"}
            </button>
          </form>

          <div className="auth-meta">
            <small>© {new Date().getFullYear()} AMAN AI • أمن المعلومات أولًا</small>
          </div>
        </div>
      </div>
    );
  }

  
  return (
    <div className="admin-shell rtl">
      <aside className="admin-sidebar">
        <div className="sidebar-logo">
          <div className={`auth-logo ${loadingTable ? "logo-spin" : "logo-glow"}`} style={{ width: 48, height: 48 }}>
            <img src="/logo.png" alt="AMAN AI Logo" />
          </div>
          <div className="brand">AMAN AI</div>
        </div>

        <nav className="menu">
          <button
            className={`menu-item ${activeTable === "trusted-senders" ? "active" : ""}`}
            onClick={() => setActiveTable("trusted-senders")}
          >
            المرسلون الموثوقون
          </button>
          <button
            className={`menu-item ${activeTable === "messages" ? "active" : ""}`}
            onClick={() => setActiveTable("messages")}
          >
            الرسائل
          </button>
          <button
            className={`menu-item ${activeTable === "logs" ? "active" : ""}`}
            onClick={() => setActiveTable("logs")}
          >
            السجلات (Logs)
          </button>
        </nav>

        <div className="sidebar-foot">
          <button className="btn btn-ghost" onClick={() => setLoggedIn(false)}>
            تسجيل الخروج
          </button>
        </div>
      </aside>

      <main className="admin-main">
        <header className="admin-header">
          <h2>
            {activeTable === "trusted-senders" && "جدول المرسلين الموثوقين"}
            {activeTable === "messages" && "جدول الرسائل"}
            {activeTable === "logs" && "سجل العمليات"}
          </h2>
          <div className="badge">قراءة فقط</div>
        </header>

        <section className="admin-content">
          {error && <div className="alert error">{error}</div>}

          {loadingTable ? (
            <div className="skeleton-table" aria-label="loading">
              <div className="bar" />
              <div className="bar" />
              <div className="bar" />
            </div>
          ) : data.length === 0 ? (
            <div className="empty">
              لا توجد بيانات للعرض.
              <button className="btn btn-secondary" onClick={() => fetchTable(activeTable)}>
                إعادة التحميل
              </button>
            </div>
          ) : (
            <div className="table-wrap">
              <table className="table-modern">
                <thead>
                  <tr>
                    {Object.keys(data[0]).map((col) => (
                      <th key={col}>{col}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {data.map((row, idx) => (
                    <tr key={idx}>
                      {Object.keys(data[0]).map((col) => (
                        <td key={col}>{String(row[col] ?? "")}</td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>
      </main>
    </div>
  );
}
