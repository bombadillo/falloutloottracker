userSessionHandler = require '../services/userSessionHandler'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'
lootContainerHandler = require '../services/lootContainerHandler'
lootDataMapper = require '../services/lootDataMapper'
lootStatusRetriever = require '../services/lootStatusRetriever'
lootFilterParser = require '../services/lootFilterParser'

lootRetriever = require '../services/lootRetriever'
lootPropertyRetriever = require '../services/lootPropertyRetriever'
urlHandler = require '../services/urlHandler'

handle = (app) ->
  app.get('/loot', (request, response) ->
    userSessionHandler.getUserFromCookie(request).then (user) ->
      if user
        filter = lootFilterParser.parse(request.query).then (filter) ->
          filter.user = user._id
          lootRetriever.getAll(filter).then (loot) ->
            response.render(
              'pages/loot',
                user: user
                loot: loot
                filter: request.query
            )
      else
        response.redirect('/login')
  )

  app.get('/loot/add', (request, response) ->
    user = userSessionHandler.isLoggedIn request
    if user
      lootPropertyRetriever.getProperties().then (properties) ->
        response.render(
          'pages/addLoot'
          lootTypes: properties.lootTypes
          lootLevels: properties.lootLevels
          lootStatuses: properties.lootStatuses
          user: user
        )
  )

  app.post('/loot/add', (request, response) ->
    userSessionHandler.getUserFromCookie(request).then (user) ->
      if user
        data = lootDataMapper.map request.body, user
        lootContainerHandler.insert(data).then (result) ->
          response.redirect '/loot'
  )

  app.get('/loot/edit/:id', (request, response) ->
    updated = request.query.updated
    lootId = request.params.id
    userSessionHandler.getUserFromCookie(request).then (user) ->
      lootRetriever.getSingle(lootId).then (loot) ->
        response.render(
          'pages/editLoot',
          user: user
          loot: loot
          updated: updated
        )
  )

  app.post('/loot/edit', (request, response) ->
    userSessionHandler.getUserFromCookie(request).then (user) ->
      data = lootDataMapper.map request.body, user
      lootContainerHandler.update(data).then (result) ->
        updated = if result then 1 else 0
        url = urlHandler.removeGetParams(request.get('referer'))
        response.redirect url + "?updated=#{updated}"
  )

exports = this
exports.handle = handle
