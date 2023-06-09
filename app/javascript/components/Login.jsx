import axios from 'axios';
import React, { useRef, useState } from 'react';
import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, TextField } from '@material-ui/core';

function Login({ setUser, isOpen, setOpen }) {

    const [text, setText] = useState("Login to your account.");
    const emailRef = useRef("");
    const passwordRef = useRef("");

    const handleSubmit = () => {
        axios.post('/login', {
            user: {
                email: emailRef.current.value,
                password: passwordRef.current.value
            }
        }, {
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            }
        }).then((response) => {
            user = response.data;
            user.auth = response.headers.authorization;
            setUser(user);
            setOpen(false);
        }).catch((error) => {
            setText(error.message);
        });
    };

    const handleCancel = () => {
        setOpen(false);
    };

    return (
        <Dialog open={isOpen} onClose={handleCancel}>
            <DialogTitle>Login</DialogTitle>
            <DialogContent>
                <DialogContentText>
                    {text}
                </DialogContentText>
                <TextField
                    margin="dense"
                    id="regEmail"
                    label="Email Address"
                    type="email"
                    fullWidth
                    variant="standard"
                    inputRef={emailRef}
                />
                <TextField
                    margin="dense"
                    id="regPassword"
                    label="Password"
                    type="password"
                    fullWidth
                    variant="standard"
                    inputRef={passwordRef}
                />
            </DialogContent>
            <DialogActions>
                <Button onClick={handleSubmit}>Submit</Button>
                <Button onClick={handleCancel}>Cancel</Button>
            </DialogActions>
        </Dialog>
    )
}

export default Login