const User = require('../models/userModel')

exports.addUser = (req, res) => {
    if (req) {
        console.log(req.body)
        const {email, username} = req.body
        if (username.trim().length == 0) {
            console.log("Username is required")
            res.status(400).json({message: "no_username"})
        }else if (email.trim().length == 0) {
            console.log("Email is required")
            res.status(400).json({message: "no_email"})
        }else {
            const user = new User(email.trim(), username.trim())
            User.addUser(user, (error, result) => {
                if (error) {
                    if (error.kind == 'user_exist') {
                        res.status(400).json({message: 'user_exist', data: null})
                    }else {
                        res.status(500).json({message: 'server_error', data: null})
                    }
                }else {
                    res.status(200).json({message: 'user_added', data: result})
                }
            })
        }
    }
}