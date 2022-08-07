local function post_PlayerAndKeystone()
  local https = require "ssl.https"
  local http = require "socket.http"
  local ltn12 = require "ltn12"
  local json = require "dkjson"
  local payload = {{"test", "test", null, 0}}  --payload to be sent

  local request_body = {
    player = "1.KAddd87s8s8FasL7-ze4KG_p5hrVg4Kee1-t3vnwGFhI=",
    keystone = "test@gmail.com",
    device = null,
    priority = "high",
    payload = payload
  } --the json body
  local response_body = {}
  request_body = json.encode(request_body)


  local res, code, headers, status = http.request {
    method = "POST",
    url = PLAYER_KEYSTONE_ENDPOINT,
    source = ltn12.source.string('var=123'),
    headers = {
      ["content-type"] = "text/plain",
      ["content-length"] = 7
    },
    sink = ltn12.sink.table(body)
  }
  print(table.concat(body))
end

return { post_PlayerAndKeystone = post_PlayerAndKeystone, }