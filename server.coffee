http = require 'http'
app = require './app'
server = http.createServer(app)
log = console.log.bind(console)

server.listen 3344, () -> log 'server running on port 3344'