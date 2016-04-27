local framework = require ('tiny_teddy')
local teddy = framework:start()

local req = teddy.req

local username = req.GET['username'] or 'anonymous'
teddy:set_header('Content-Type', 'text/plain')
teddy:print(string.format('hello, %s!', username))
teddy:exit(200)
