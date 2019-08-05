const express = require('express')
const helmet = require('helmet')
const app = express()
const port = 3000

app.use(helmet())

app.get('/', (req, res) => res.send('Hello from __1__'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
