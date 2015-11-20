indexRouteHandler = require '../routeHandlers/index'
loginRouteHandler = require '../routeHandlers/login'
logoutRouteHandler = require '../routeHandlers/logout'
registerRouteHandler = require '../routeHandlers/register'
lootRouteHandler = require '../routeHandlers/loot'

handleRequests = (app) ->

  indexRouteHandler.handle app
  loginRouteHandler.handle app
  logoutRouteHandler.handle app
  registerRouteHandler.handle app
  lootRouteHandler.handle app

exports = this
exports.handleRequests = handleRequests
