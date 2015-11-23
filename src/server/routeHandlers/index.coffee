lootInfoRetriever = require '../services/lootInfoRetriever'
userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootStatusRetriever = require '../services/lootStatusRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'

handle = (app) ->
  app.get('/', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        lootInfoRetriever.getAll(user).then (loot) ->
          lootTypeRetriever.getAll(true).then (lootTypes) ->
            lootStatusRetriever.getAll(true).then (lootStatuses) ->
              lootLevelRetriever.getAll(true).then (lootLevels) ->
                console.log 'displaying loot'
                response.render(
                  'pages/index',
                    user: user
                    loot: loot
                    lootTypes: lootTypes
                    lootStatuses: lootStatuses
                    lootLevels: lootLevels
                )
      else
        response.redirect('/login')
  )

exports = this
exports.handle = handle
