userSessionHandler = require '../services/userSessionHandler'

handle = (app) ->
  app.get('/logout', (request, response) ->
    user = userSessionHandler.getUserByName request
    if user
      response.clearCookie 'vaultDweller'
      response.redirect '/'
  )

exports = this
exports.handle = handle
