local _M = {}

local http = require "resty.http"
local cjson = require "cjson"
local req_get_headers = ngx.req.get_headers
local req_set_header = ngx.req.set_header

local jwt = require "resty.jwt"

 function _M.run(plugin_conf)

    local request_uri = ngx.var.uri
    --ngx.log(ngx.ERR, request_uri) metrics
  
      if request_uri ~= plugin_conf.login_uri then
          local authorization_header = req_get_headers()["x-authorization"]
          ngx.log(ngx.ERR, authorization_header)
          
           if not authorization_header or authorization_header == nil or authorization_header == '' then 
              ngx.log(ngx.ERR, authorization_header)
              ngx.status = 400
              ngx.header.content_type = 'application/json'
              ngx.print('{"status": 401, "errors": [{"status": 401, "code": "ACCESS_DENIED", "message": "Access Denied"}]}')
              ngx.exit(400)
            else  
             local key ="Passw0rd1"
             local token = "eyJhbGciOiJIUzUxMiJ9.eyJ1aWQiOiJnbHAiLCJpc3MiOiJHTFAiLCJqdGkiOiIyNmYzZDYxNi0wMWM2LTQ0NDUtYWQwOC1mZWFlMmYyYTc0NGQifQ.SgMAwXHAatwT8Y-0WgSGnmnM5pAljOyX8nRA-T5kNE4e4n1iE_1PjbsqTXL2KlP3RUL6y7qWpFOK8GchAe4lcA"
             --local jwt_obj = jwt:verify(key, authorization_header)
             
             local jwt_obj = jwt:verify(key, authorization_header, 0)
             ngx.log(ngx.ERR, jwt_obj)

            if not jwt_obj["verified"] then
                ngx.log(ngx.ERR, jwt_obj)
                ngx.status = 400
                ngx.header.content_type = 'application/json'
                ngx.print('{"status": 401, "errors": [{"status": 401, "code": "ACCESS_DENIED", "message": "Access Denied"}]}')
                ngx.exit(400)
            
            end
            
            
            --local jwtToken = json.data.jwtToken
            
            --req_set_header("jwtToken", jwtToken)
            
           end
       
      end
 
 end -- ending M_execute function
 
 return _M
