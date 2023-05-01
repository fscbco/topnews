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
  const [starredStories, setStarredStories] = useState([])
  const [starredStoriesMode, setStarredStoriesMode] = useState(false)

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

  const starStory = async (storyId) => {
    const response = await fetch(`${URL}/star_story`, {
      method: "POST",
      headers: new Headers({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": `Basic ${base64.encode(`${userEmail}:${userPassword}`)}`
      }),
      body: JSON.stringify({ story_id: storyId }),
      })

    if (!response.ok) {
        const message = `An error has occured: ${response.status}`
        throw new Error(message);
    } else {
      // make it easier and faster
      fetchStoriesJSON()
    }
  }

  const showAllStories = () => {
    setStarredStoriesMode(false)
  }

  const showOnlyStarredStories = () => {
    let starredStories = stories.filter(story => story.starred)
    setStarredStories(starredStories)
    setStarredStoriesMode(true)
  }

  return (
    <div className="App">
      <header className="App-header">
        <div></div>
      </header>
      <HomePage 
        currentUser={currentUser} 
        stories={stories}
        starredStories={starredStories}
        starStory={starStory}
        starredStoriesMode={starredStoriesMode}
        showOnlyStarredStories={showOnlyStarredStories}
        showAllStories={showAllStories}
      />
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
