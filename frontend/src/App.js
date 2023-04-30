import React from 'react';
import './App.css';
import HomePage from './components/HomePage'
import Login from './components/Login'
import { useEffect, useState } from "react"
import base64 from "base-64"

function App() {
  const URL = 'http://localhost:3000'
  const [currentUser, setCurentUser] = useState(null)
  const [userEmail, setUserEmail] = useState('')
  const [userPassword, setUserPassword] = useState('')
  const [stories, setStories] = useState([])

  useEffect(() => {
    if (currentUser) fetchStoriesJSON()
  }, [currentUser]) 

  const loginUser = () => {
    authenticateUser()
  }

  const logout = async () => {
    
    const response = await fetch(`${URL}/users/sign_out`, {
      method: "DELETE"
    })

    console.log(response)
    if (!response.ok) {
      const message = `An error has occured: ${response.status}`
      throw new Error(message)
    }
    setCurentUser(null)
  }

  const authenticateUser = async () => {
    const response = await fetch(`${URL}/fetch_current_user`, {
      headers: new Headers({
        "Authorization": `Basic ${base64.encode(`${userEmail}:${userPassword}`)}`
    })})

    if (!response.ok) {
        const message = `An error has occured: ${response.status}`
        throw new Error(message);
    }

    const currentUser = await response.json()
    setCurentUser(currentUser)
    console.log(currentUser)
  }

  const fetchStoriesJSON = async () => {
    const response = await fetch(`${URL}/stories/`, {
        headers: new Headers({
          "Authorization": `Basic ${base64.encode(`${userEmail}:${userPassword}`)}`
        })})

    if (!response.ok) {
        const message = `An error has occured: ${response.status}`
        throw new Error(message)
    }

    const stories = await response.json()
    setStories(stories)
  }

  return (
    <div className="App">
      <header className="App-header">
        <div></div>
      </header>
      <HomePage currentUser={currentUser} stories={stories}/>
      <Login 
        currentUser={currentUser} 
        loginUser={loginUser} 
        logout={logout}
        userEmail={userEmail} 
        setUserEmail={setUserEmail} 
        userPassword={userPassword}
        setUserPassword={setUserPassword}
      />
    </div>
  );
}

export default App;
