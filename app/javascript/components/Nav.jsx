import React from 'react'
import axios from 'axios'
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';

function Nav({ user, setUser, setOpenLogin, setOpenRegister }) {

    openLogin = () => {
        setOpenLogin(true)
    }

    openRegister = () => {
        setOpenRegister(true)
    }

    handleLogout = () => {
        axios.delete('/logout', {
            headers: {
                Authorization: user.auth
            }
        }).then((response) => {
            window.sessionStorage.removeItem("user")
            setUser(null)
        }).catch((error) => {
            console.log(error)
        })
    }

    return (
        <Box sx={{ flexGrow: 1 }}>
            <AppBar position="static">
                <Toolbar>
                    <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                        TOPNEWS
                    </Typography>
                    {user === null && <Button onClick={openLogin} color="inherit">Login</Button>}
                    {user === null && <Button onClick={openRegister} color="inherit" >Register</Button>}
                    {user !== null && <Button color="inherit">Hello, {user.first_name}!</Button>}
                    {user !== null && <Button onClick={handleLogout} color="inherit">Logout</Button>}
                </Toolbar>
            </AppBar>
        </Box>
    )
}

export default Nav