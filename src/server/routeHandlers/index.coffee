lootInfoRetriever = require '../services/lootInfoRetriever'
userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootStatusRetriever = require '../services/lootStatusRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'

handle = (app) ->
  app.get('/', (request, response) ->
    userSessionHandler.getUserByName(request).then (user) ->
      response.render 'pages/index', user: user
  )

exports = this
exports.handle = handle
