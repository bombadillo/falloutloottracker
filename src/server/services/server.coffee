express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
app = express()
app.use cookieParser()
app.use bodyParser.urlencoded(extended: true)

start = ->
  app.set('port', (process.env.PORT || 5000))
  app.use(express.static(__dirname + '/../../client/'))
  app.set('views', __dirname + "/../views")
  app.set('view engine', 'ejs')

  app.listen(app.get('port'), ->
    console.log('The app is running on port', app.get('port'))
  )

exports = this
exports.start = start
exports.app = app
