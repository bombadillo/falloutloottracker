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
    userSessionHandler.doesUserExist(userName).then (user) ->
      console.log 'got user'
      console.log user
      if user
        response.cookie 'vaultDweller', request.body.vaultDweller
        response.redirect '/'
      else
        response.redirect '/register'
  )

exports = this
exports.handle = handle
