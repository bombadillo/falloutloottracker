userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'
lootContainerHandler = require '../services/lootContainerHandler'
lootDataMapper = require '../services/lootDataMapper'
lootStatusRetriever = require '../services/lootStatusRetriever'
lootInfoRetriever = require '../services/lootInfoRetriever'

handle = (app) ->
  app.get('/loot', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      if user
        filter = request.query
        filter.user = user._id
        lootInfoRetriever.getAll(filter).then (loot) ->
          lootTypeRetriever.getAll(true).then (lootTypes) ->
            lootStatusRetriever.getAll(true).then (lootStatuses) ->
              lootLevelRetriever.getAll(true).then (lootLevels) ->
                console.log 'displaying loot'
                response.render(
                  'pages/loot',
                    user: user
                    loot: loot
                    lootTypes: lootTypes
                    lootStatuses: lootStatuses
                    lootLevels: lootLevels
                )
      else
        response.redirect('/login')
  )

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
              user: user
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

  app.get('/loot/edit/:id', (request, response) ->
    lootId = request.params.id
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      lootInfoRetriever.getSingle(lootId).then (lootContainer) ->
        lootTypeRetriever.getAll().then (lootTypes) ->
          lootLevelRetriever.getAll().then (lootLevels) ->
            lootStatusRetriever.getAll().then (lootStatuses) ->
              response.render(
                'pages/editLoot',
                lootContainer: lootContainer
                lootTypes: lootTypes
                lootLevels: lootLevels
                lootStatuses: lootStatuses
                user: user
              )
  )

  app.post('/loot/edit', (request, response) ->
    userName = request.cookies.vaultDweller
    userSessionHandler.getUserByName(userName).then (user) ->
      data = lootDataMapper.map request.body, user
      lootContainerHandler.update(data).then (result) ->
        response.redirect request.get 'referer'
  )

exports = this
exports.handle = handle
