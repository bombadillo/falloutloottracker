lootInfoRetriever = require '../services/lootInfoRetriever'
userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootStatusRetriever = require '../services/lootStatusRetriever'

handle = (app) ->
  app.get('/', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        lootInfoRetriever.getAll(user).then (loot) ->
          lootTypeRetriever.getAll(true).then (lootTypes) ->
            lootStatusRetriever.getAll(true).then (lootStatuses) ->
              console.log 'displaying loot'
              response.render(
                'pages/index',
                  user: user
                  loot: loot
                  lootTypes: lootTypes
                  lootStatuses: lootStatuses
              )
      else
        response.redirect('/login')
  )

exports = this
exports.handle = handle
