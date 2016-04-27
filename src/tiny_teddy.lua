local _m = {}

function _m.start()

  local teddy = {

    set_header = function (self, name, value)
      ngx.header[name] = value
    end,
    
    route = function (self, uri, handler)
      self:log(self.DEBUG, '>>> enter teddy.route')

      local uri_matched = self:_match_uri(uri)
      if uri_matched then
        status_code = handler(self.req)
        if status_code ~= nil then
          ngx.exit(status_code)
        end
      end

      self:log(self.DEBUG, '<<< exit teddy.route')
    end,

    print = function (self, value)
      self:log(self.DEBUG, '>>> enter teddy.print')

      if type(value) == 'string' then
        ngx.say(value)
      else
        self:_warn_unsupported_type('print', 2, type(value))
      end

      self:log(self.DEBUG, '<<< exit teddy.print')
    end,

    exit = function (self, status_code)
      ngx.exit(status_code)
    end,

    ERR = ngx.ERR,
    WARN = ngx.WARN,
    INFO = ngx.INFO,
    DEBUG = ngx.DEBUG,
    log = function (self, log_level, msg)
      ngx.log(log_level, msg)      
    end,

    _init = function (self)
      self:log(self.DEBUG, '>>> enter teddy._init')

      self.req = {
        HEADERS = ngx.req.get_headers(),
        METHOD = ngx.req.get_method(),
        URI = ngx.var.uri
      }
      if self.req.METHOD == 'GET' then
        self.req.GET = ngx.req.get_uri_args()
      end
      if self.req.METHOD == 'POST' then
        ngx.req.read_body()
        self.req.POST = ngx.req.get_post_args()
      end
      self:set_header('Content-Type', 'text/html')

      self:log(self.DEBUG, '<<< exit teddy._init')
    end,

    _warn_unsupported_type = function (self, func_name, index, type_)
      local tmpl = 'bad argument #d to %s (%s not supported yet)'
      self:log(self.WARN, string.format(tmpl, index, func_name, type_))
    end,

    _match_uri = function (self, uri)
      if type(uri) == 'boolean' then
        return uri
      elseif type(uri) == 'string' then
        return uri == self.req.URI
      else
        self:_warn_unsupported_type('_match_uri', 2, type(uri))
        return false
      end
    end,

  }

  teddy:_init()

  return teddy

end

return _m
