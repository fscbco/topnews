import React from 'react';

function Login(props) {
    const handleEmailChange = (e) => {
        props.setUserEmail(e.target.value)
    }

    const handlePasswordChange = (e) => {
        props.setUserPassword(e.target.value)
    }

    const handleSubmit = () => {
        props.loginUser()
    }

    const handleLogout = () => {
        props.logout()
    }

    return (
        <div className="login-block">
            {props.currentUser ? 
            <div className="login-form">
                <p>Hello {props.currentUser.first_name}!</p>
                <button onClick={handleLogout}>Log Out</button>
            </div>
             :
            <div className="login-form">
                <input type='email' name='email' value={props.userEmail} onChange={(e) => handleEmailChange(e)} placeholder='Enter Your Email'/>
                <input type='password' name='password' value={props.userPassword} onChange={(e) => handlePasswordChange(e)} placeholder='Enter Your Password'/>
                <button className="login-button" type="primary" onClick={() => handleSubmit()} >Login</button>
            </div>
            }
        </div>
    )
}

export default Login