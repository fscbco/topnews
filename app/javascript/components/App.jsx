import React, { useEffect, useState } from 'react'
import Nav from './Nav'
import Stories from './Stories'
import Login from './Login'
import Register from './Register'
import { Container } from '@material-ui/core'

function App() {

  [user, setUser] = useState(null)

  updateUserSession = () => {
    if (user) {
      window.sessionStorage.setItem("user", JSON.stringify(user))
    }
  }

  checkSession = () => {
    let u = window.sessionStorage.getItem("user")
    if (u !== null) {
      setUser(JSON.parse(u))
    }
  }

  useEffect(checkSession, [])
  useEffect(updateUserSession, [user])

  const [openLogin, setOpenLogin] = React.useState(false);
  const [openRegister, setOpenRegister] = React.useState(false);

  return (
    <Container maxWidth="xl">
      <Nav user={user} setUser={setUser} setOpenLogin={setOpenLogin} setOpenRegister={setOpenRegister} />
      <Login setUser={setUser} isOpen={openLogin} setOpen={setOpenLogin} />
      <Register setUser={setUser} isOpen={openRegister} setOpen={setOpenRegister} />
      <Stories user={user} setOpenLogin={setOpenLogin} />
    </Container>
  )
}

export default App