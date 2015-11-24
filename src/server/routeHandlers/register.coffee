userSessionHandler = require '../services/userSessionHandler'
userRegister = require '../services/userRegister'

oResponse = undefined

handle = (app) ->
  app.get('/register', (request, response) ->
    oResponse = response
    user = userSessionHandler.isLoggedIn request
    if user
      response.redirect '/'
    else
      render undefined, user
  )

  app.post('/register', (request, response) ->
    oResponse = response
    userName = request.body.vaultDweller
    userSessionHandler.getUserByName(request).then (user) ->
      if user
        message = "Username #{request.body.vaultDweller} already exists."
        render message, user
      else
        userRegister.register(userName).then (result) ->
          if result
            response.cookie 'vaultDweller', userName
            response.redirect '/'
          else
            message = 'Registration failed'
            render message, user
  )

render = (message, user) ->
  oResponse.render(
    'pages/register',
    message: message
    user: user
  )

exports = this
exports.handle = handle
