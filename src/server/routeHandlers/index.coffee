lootInfoRetriever = require '../services/lootInfoRetriever'
userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootTypeConvertor = require '../services/lootTypeConvertor'

handle = (app) ->
  app.get('/', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        lootInfoRetriever.getAll(user).then (loot) ->
          lootTypeRetriever.getAll().then (lootTypes) ->
            console.log 'displaying loot'
            aLootTypes = lootTypeConvertor.toArray lootTypes
            response.render(
              'pages/index',
              user: user, loot: loot, lootTypes: aLootTypes
            )
      else
        response.redirect('/login')
  )

exports = this
exports.handle = handle
