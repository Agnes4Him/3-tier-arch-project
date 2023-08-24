const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController')

router.post('/', userController.addUser)
//router.get('/get-users', userController.getUsers)

module.exports = router