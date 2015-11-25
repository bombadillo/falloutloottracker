userSessionHandler = require '../services/userSessionHandler'

handle = (app) ->
  app.get('/logout', (request, response) ->
    user = userSessionHandler.getUserFromCookie request
    if user
      response.clearCookie 'vaultDweller'
      response.redirect '/'
  )

exports = this
exports.handle = handle
