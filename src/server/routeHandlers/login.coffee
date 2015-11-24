userSessionHandler = require '../services/userSessionHandler'

handle = (app) ->
  app.get('/login', (request, response) ->
    user = userSessionHandler.isLoggedIn request
    if user
      response.redirect '/'
    else
      response.render('pages/login', user: user)
  )

  app.post('/login', (request, response) ->
    userName = request.body.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        response.cookie 'vaultDweller', userName
        response.redirect '/'
      else
        response.redirect '/register'
  )

exports = this
exports.handle = handle
