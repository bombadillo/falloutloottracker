server = require './services/server'
requestHandler = require './services/requestHandler'

server.start()
requestHandler.handleRequests server.app
