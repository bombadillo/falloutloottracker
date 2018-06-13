server = require './services/server'
requestHandler = require './services/requestHandler'

process.on 'uncaughtException', (err) ->
  console.log 'uncaught exception'

server.start()
requestHandler.handleRequests server.app

