## tiny teddy

> Tiny teddy is a tiny lua web framework based on nginx and ngx_lua_module. It aims to provide a tiny framework for developing interfaces rapidly. It is designed to keep tiny and powerful.

### requires

* [nginx](http://nginx.org/)
* [lua-nginx-module](https://github.com/openresty/lua-nginx-module) 0.55+

### features

* uri route(string match, boolean) supported
* GET and POST args supported

### TODOs

* [ ] support regex route

### install

1. Install [openresty](http://openresty.org/en/).

2. Add a nginx server config to use tiny teddy.

        lua_package_path 'path/to/tiny_teddy/src/?.lua;;';

        server {
            listen 8000;
            server_name localhost;

            access_log /path/to/log/access.log;
            error_log /path/to/log/error.log debug;

            location / {
                content_by_lua_file /path/to/project/index.lua;
            }
        }

3. Use `tiny_teddy` in `index.lua`.

        local framework = require ('tiny_teddy')
        local teddy = framework:start()

        local req = teddy.req

        local username = req.GET['username'] or 'anonymous'
        teddy:set_header('Content-Type', 'text/plain')
        teddy:print(string.format('hello, %s!', username))
        teddy:exit(200)

4. Start server and visit `localhost:8000/?username=yourname`.
