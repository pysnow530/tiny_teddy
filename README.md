## tiny teddy ##

> Tiny teddy is a tiny lua web framework based on openresty. It aims to provide a tiny framework for develop interfaces rapidly. It is designed to keep tiny and rapid.

### features ###

* uri route supported
* get and post args supported

### install ###

1. Install [openresty](http://openresty.org/en/).

2. Add a nginx server config to use tiny teddy.

    lua_package_path '$TINY_TEDDY_SRC_PATH/?.lua;;';

    server {
        listen 8000;
        server_name tiny.teddy;
    
        access_log $LOG_PATH/access.log;
        error_log $LOG_PATH/error.log debug;

        location / {
            content_by_lua_file $PROJECT_PATH/index.lua;
        }
    }

3. Place `src/tiny_teddy.lua` to lua_package_path and use it in `$PROJECT_PATH/index.lua`.

    local framework = require ('tiny_teddy')
    local teddy = framework:start()
    
    function hello_handler(req)
      teddy:set_header('Content-Type', 'text/plain')
      teddy:print('hello, world!')
      return 200
    end

    teddy:route('/hello/', hello_handler)
    
4. Start server and visit tiny.teddy:8000/hello/.
