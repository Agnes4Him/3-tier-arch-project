const express = require('express')
const cors = require('cors')
const dotenv = require('dotenv')
const userRoute = require('./src/routes/userRoutes')

dotenv.config()

const app = express()
const port = 7000

app.use(express.json())
app.use(express.urlencoded({extended:true}))
app.use(cors())

app.use(userRoute)

app.listen(port, () => {
    console.log(`Listening on port ${port}`)
})