userSessionHandler = require './userSessionHandler'
lootInfoRetriever = require './lootInfoRetriever'

handleRequests = (app) ->
  app.get('/', (request, response) ->
    user = userSessionHandler.getUser request
    if user
      lootInfoRetriever.getAll(user).then (loot) ->
        console.log 'displaying loot'   
        response.render('pages/index', user: user, loot: loot)
    else
      response.render('pages/login')
  )

  app.get('/login', (request, response) ->
    user = userSessionHandler.getUser request
    if user
      response.redirect '/'
    else
      response.render('pages/login')
  )

  app.post('/login', (request, response) ->
    response.cookie 'vaultDweller', request.body.vaultDweller
    response.redirect '/'
  )

  app.get('/logout', (request, response) ->
    user = userSessionHandler.getUser request
    if user
       response.clearCookie 'vaultDweller'
      response.redirect '/'
  )

exports = this
exports.handleRequests = handleRequests
