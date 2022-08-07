-- https://wowpedia.fandom.com/wiki/World_of_Warcraft_API

SLASH_TEST1 = "/test"

KEYSTONE_ID = 180653 -- SL mythic keystone item ID
BAG_SLOTS = 5

-- UNUSED
-- Identifies the keystone in the player's bags
local function findKeystoneInBags()
  -- for each bag
  for bagSlot = 0, BAG_SLOTS - 1, 1 do
    local bagSize = GetContainerNumSlots(bagSlot)
    -- for each slot
    for itemSlot = 1, bagSize, 1 do
      local itemID = GetContainerItemID(bagSlot, itemSlot)

      -- item is a Mythic Keystone 
      if itemID ~= nil and C_Item.IsItemKeystoneByID(itemID) then
        print("keystone found in bag: " .. bagSlot .. " slot: " .. itemSlot)
        local itemName, itemLink = GetItemInfo(itemID)
        return itemName, itemLink
      end
    end
  end
  return nil, nil
end

-- Gets the player's keystone information
local function getPlayerKeystone()
  local keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
  local dungeonID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
  local dungeonName = C_ChallengeMode.GetMapUIInfo(dungeonID)

  local keystoneObj = {
    ["level"] = keystoneLevel,
    ["dungeonId"] = dungeonID,
    ["dungeonName"] = dungeonName,
  }
  return keystoneObj
end

-- Gets the player's character information
local function getPlayerCharacterInfo()
  local name, _ = UnitName("player")
  local class, _, _ = UnitClass("player")
  local race, _, raceID = UnitRace("player")
  local faction = C_CreatureInfo.GetFactionInfo(raceID)["name"]
  local realm = GetRealmName()

  local playerObj = {
    ["name"] = name,
    ["class"] = class,
    ["race"] = race,
    ["faction"] = faction,
    ["realm"] = realm,
  }
  return playerObj
end

-- main handler
local function handle_test()

  print("slash command recognized")

  -- GATHER INFO -- 
  --local _, _ = findKeystoneInBags() -- no real use for this atm
  local keystoneObj = getPlayerKeystone()
  print("keystone information generated")
  local playerObj = getPlayerCharacterInfo()
  print("player information generated")

  local apiObject = {
    ["player"] = playerObj,
    ["keystone"] = keystoneObj,
  }
  print("api object created")

  -- for key, value in pairs(apiObject) do
  --   for k, v in pairs(value) do
  --     print(k, "--", v)
  --   end
  -- end

  -- API SERVICE -- 
  print("starting api service")
  local ApiService = require "ApiService"
  print("require success")
  -- ApiService.getRequest("/keystones")
  ApiService.postRequest("/info", apiObject)
  print("api service successful")
  print("wcyd")
end

-- local testObj = {
--   ["player"] = {
--     ["name"] = "name",
--     ["class"] = "class",
--     ["race"] = "race",
--     ["faction"] = "faction",
--     ["realm"] = "realm",
--   },
--   ["keystone"] = {
--     ["level"] = 15,
--     ["dungeonId"] = 12312,
--     ["dungeonName"] = "dungeonName",
--   },
-- }

-- local ApiService = require "ApiService"
-- --ApiService.getRequest("/players/1")
-- ApiService.postRequest("/info", testObj)


SlashCmdList["TEST"] = handle_test



