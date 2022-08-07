local json = require("json")
local http = require("socket.http")
local ltn12 = require 'ltn12'

local url = "http://localhost:8080" -- will change once deployed

local function getRequest(endpoint) --post_PlayerAndKeystone
  local body = {}

  local res, code, headers, status = http.request{
    url = url .. endpoint,
    sink = ltn12.sink.table(body)
  }

  local response = table.concat(body)
  print(response)
end

local function postRequest(endpoint, dataObj) --post_PlayerAndKeystone
  local body = {}

  local msg = json.encode(dataObj)
  print(msg)

  local res, code, headers, status = http.request{
    method = "POST",
    url = url .. endpoint,
    source = (ltn12.source.string(msg)),
    headers = {
      ["content-type"] = "application/json",
      ["content-length"] = string.len(msg)
    },
    sink = ltn12.sink.table(body)
  }

  local response = table.concat(body)
  print(response)
end

local function test()
  print("api service reacted")
end

return {
  getRequest = getRequest,
  postRequest = postRequest,
  test = test,
}