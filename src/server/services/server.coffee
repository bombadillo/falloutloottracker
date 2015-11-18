express = require 'express'
app = express()

start = ->
  app.set('port', (process.env.PORT || 5000))
  app.use(express.static(__dirname + '/../../client/'))
  app.set('views', __dirname + "/../views")
  app.set('view engine', 'ejs')

  app.get('/', (request, response) ->
    response.render('pages/index')
  )

  app.listen(app.get('port'), ->
    console.log('The app is running on port', app.get('port'))
  )

exports = this
exports.start = start
