const db = require("../config/dbConfig")

class User {
    constructor(email, username) {
        this.email = email
        this.username = username   
    }

    static addUser(newUser, cb) {
        // First check for existing user...
        db.query('SELECT* FROM user WHERE email = ? OR username = ?', [newUser.email, newUser.username], (err, res) => {
            if (err) {
                console.log(err)
                cb(err, null)
                return;
            }else if (res.length > 0) {
                console.log('User already exist')
                cb({kind : 'user_exist'}, null)
                return;
            }else{
                db.query('INSERT INTO user (email, username) VALUES(?, ?)', [newUser.email, newUser.username], (insertErr, insertRes) => {
                    if (insertErr) {
                        console.log(insertErr)
                        cb(insertErr, null)
                        return;
                    }else {
                        console.log("User successfully added")
                        //cb(null, insertRes.insertId)
                        db.query('SELECT* FROM user', (selectErr, selectRes) => {
                            if (selectErr) {
                                console.log(selectErr)
                                cb(selectErr, null)
                                return;
                            }else {
                                console.log('All users:', selectRes)
                                cb(null, selectRes)
                            }
                        })
                    }
                })
            }
        })
    }
}

module.exports = User;