
import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import './App.css';
import AdminDashboard from "./components/AdminDashboard";



const Home = ({ lang, toggleLang }) => {
  const [message, setMessage] = useState('');
  const [sender, setSender] = useState('');
  const [result, setResult] = useState(null);

  // الموك (بدل الاتصال بالباك-إند)
  const handleSubmit = async (e) => {
    e.preventDefault();
    setResult(null);

    const fakeResult = {
      status: "Suspicious",
      fraud_score: Math.random().toFixed(2),
      trusted_sender: Math.random() > 0.5
    };

    setTimeout(() => setResult(fakeResult), 1000);
  };

  const t = {
    en: {
      title: 'AMAN AI',
      desc: 'Protect yourself from financial fraud intelligently',
      start: 'Start Analysis',
      contact: 'Contact Us',
      admin: 'Admin',
      lang: 'العربية',
      message: 'Suspicious Message',
      sender: 'Sender (Phone or Email)',
      analyze: 'Analyze',
      result: 'Analysis Result',
      status: 'Status',
      score: 'Fraud Score',
      trusted: 'Trusted Sender?'
    },
    ar: {
      title: 'أمان AI',
      desc: 'احمِ نفسك من الاحتيال المالي بذكاء',
      start: 'ابدأ التحليل',
      contact: 'تواصل معنا',
      admin: 'لوحة التحكم',
      lang: 'English',
      message: 'نص الرسالة',
      sender: 'رقم الجوال أو الإيميل',
      analyze: 'تحليل',
      result: 'نتيجة التحليل',
      status: 'الحالة',
      score: 'نسبة الاحتيال',
      trusted: 'المرسل موثوق؟'
    }
  };
  const text = t[lang];

  return (
    <div className={`app ${lang === 'ar' ? 'rtl' : ''}`}>
      <header className="header">
        <img src="/logo.png" alt="AMAN Logo" className="logo" />
        <h1>{text.title}</h1>
        <p>{text.desc}</p>
        <button className="lang-toggle" onClick={toggleLang}>{text.lang}</button>
      </header>

      <div className="section">
        <h2>{text.start}</h2>
        <form onSubmit={handleSubmit}>
          <label>{text.message}:</label>
          <textarea value={message} onChange={e => setMessage(e.target.value)} required />

          <label>{text.sender}:</label>
          <input type="text" value={sender} onChange={e => setSender(e.target.value)} />

          <button type="submit">{text.analyze}</button>
        </form>

        {result && (
          <div className="result-box">
            <h3>{text.result}</h3>
            <p><strong>{text.status}:</strong> {result.status}</p>
            <p><strong>{text.score}:</strong> {result.fraud_score}</p>
            <p><strong>{text.trusted}:</strong> {result.trusted_sender ? '✅' : '❌'}</p>
          </div>
        )}
      </div>
    </div>
  );
};


const Contact = ({ lang }) => (
  <div className="section">
    <h2>{lang === 'ar' ? 'تواصل معنا' : 'Contact Us'}</h2>
    <p>{lang === 'ar' ? 'هل لديك استفسار؟ راسلنا عبر البريد الإلكتروني التالي:' : 'Have a question? Email us at:'}</p>
    <p><a href="mailto:support@amanai.sa">support@amanai.sa</a></p>
  </div>
);

const Admin = ({ lang }) => <AdminDashboard lang={lang} />;


const Footer = ({ lang }) => (
  <footer className="footer">
    <Link to="/">{lang === 'ar' ? 'الرئيسية' : 'Home'}</Link>
    <Link to="/contact">{lang === 'ar' ? 'تواصل معنا' : 'Contact'}</Link>
    <Link to="/admin">{lang === 'ar' ? 'لوحة التحكم' : 'Admin'}</Link>
    <p>© 2025 AMAN AI</p>
  </footer>
);


function App() {
  const [lang, setLang] = useState('ar');
  const toggleLang = () => setLang(prev => (prev === 'ar' ? 'en' : 'ar'));

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home lang={lang} toggleLang={toggleLang} />} />
        <Route path="/contact" element={<Contact lang={lang} />} />
        <Route path="/admin" element={<Admin lang={lang} />} />
      </Routes>
      <Footer lang={lang} />
    </Router>
  );
}

export default App;
