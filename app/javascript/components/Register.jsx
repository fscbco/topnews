import axios from 'axios';
import React, { useRef, useState } from 'react';
import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, TextField } from '@material-ui/core';

function Register({ setUser, isOpen, setOpen }) {

    const [text, setText] = useState("Login to your account.");
    const nameRef = useRef("");
    const lastNameRef = useRef("");
    const emailRef = useRef("");
    const passwordRef = useRef("");
    const passwordConfirmRef = useRef("");

    const handleSubmit = () => {
        let userData = {}
        if (passwordRef.current.value !== passwordConfirmRef.current.value) {
            setText("Passwords don't match");
            return;
        }
        if (passwordRef.current.value.length < 6) {
            setText("Password must be at least 6 characters");
            return;
        }
        axios.post('/signup', {
            user: {
                first_name: nameRef.current.value,
                last_name: lastNameRef.current.value,
                email: emailRef.current.value,
                password: passwordRef.current.value,
            }
        }, {
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            }
        }).then((response) => {
            user = response.data;
            user.auth = response.headers["Authorization"];
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
            <DialogTitle>Register</DialogTitle>
            <DialogContent>
                <DialogContentText>
                    {text}
                </DialogContentText>
                <TextField
                    margin="dense"
                    id="regName"
                    label="First Name"
                    type="text"
                    fullWidth
                    variant="standard"
                    inputRef={nameRef}
                />
                <TextField
                    margin="dense"
                    id="regLastName"
                    label="Last Name"
                    type="text"
                    fullWidth
                    variant="standard"
                    inputRef={nameRef}
                />
                <TextField
                    margin="dense"
                    id="email"
                    label="Email Address"
                    type="email"
                    fullWidth
                    variant="standard"
                    inputRef={emailRef}
                />
                <TextField
                    margin="dense"
                    id="password"
                    label="Password"
                    type="password"
                    fullWidth
                    variant="standard"
                    inputRef={passwordRef}
                />
                <TextField
                    margin="dense"
                    id="regPasswordConfirm"
                    label="Confirm Password"
                    type="password"
                    fullWidth
                    variant="standard"
                    inputRef={passwordConfirmRef}
                />
            </DialogContent>
            <DialogActions>
                <Button onClick={handleSubmit}>Submit</Button>
                <Button onClick={handleCancel}>Cancel</Button>
            </DialogActions>
        </Dialog>
    )
}

export default Register