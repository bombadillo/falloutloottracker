userSessionHandler = require '../services/userSessionHandler'
userRegister = require '../services/userRegister'

handle = (app) ->
  app.get('/register', (request, response) ->
    user = userSessionHandler.isLoggedIn request
    if user
      response.redirect '/'
    else
      response.render('pages/register', message: undefined)
  )

  app.post('/register', (request, response) ->
    userName = request.body.vaultDweller
    userSessionHandler.doesUserExist(userName).then (user) ->
      if user
        message = "Username #{request.body.vaultDweller} already exists."
        response.render('pages/register', message: message)
      else
        userRegister.register(userName).then (result) ->
          if result
            response.cookie 'vaultDweller', userName
            response.redirect '/'
          else
            message = 'Registration failed'
            response.render('pages/register', message: message)
  )

exports = this
exports.handle = handle
