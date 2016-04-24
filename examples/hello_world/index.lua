local framework = require ('tiny_teddy')
local teddy = framework:start()

function hello_handler(req)
  teddy:set_header('Content-Type', 'text/plain')
  teddy:print('hello, world!')
  return 200
end

teddy:route('/hello/', hello_handler)
