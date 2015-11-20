userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'
lootContainerHandler = require '../services/lootContainerHandler'
lootDataMapper = require '../services/lootDataMapper'
lootStatusRetriever = require '../services/lootStatusRetriever'

handle = (app) ->
  app.get('/loot/add', (request, response) ->
    user = userSessionHandler.isLoggedIn request
    if user
      lootTypeRetriever.getAll().then (lootTypes) ->
        lootLevelRetriever.getAll().then (lootLevels) ->
          lootStatusRetriever.getAll().then (lootStatuses) ->
            response.render(
              'pages/addLoot'
              lootTypes: lootTypes
              lootLevels: lootLevels
              lootStatuses: lootStatuses
            )
  )

  app.post('/loot/add', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        data = lootDataMapper.map request.body, user
        lootContainerHandler.insert(data).then (result) ->
          response.redirect '/'
  )

exports = this
exports.handle = handle