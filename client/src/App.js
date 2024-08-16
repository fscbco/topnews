import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes, Link, Navigate } from 'react-router-dom';
import Login from './components/Login';
import StoryList from './components/StoryList';
import StarredStories from './components/StarredStories';
import Logout from './components/Logout';

function App() {
  const [token, setToken] = useState(localStorage.getItem('token'));

  const handleLogout = () => {
    console.log(localStorage)
    localStorage.removeItem('token');
    setToken(null);
  };

  if (!token) {
    return <Login setToken={setToken} />;
  }

  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/starred">Starred Stories</Link></li>
            <li><Logout onLogout={handleLogout} /></li>
          </ul>
        </nav>

        <Routes>
          <Route path="/" element={<StoryList />} />
          <Route path="/starred" element={<StarredStories />} />
          <Route path="/login" element={<Navigate to="/" replace />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;