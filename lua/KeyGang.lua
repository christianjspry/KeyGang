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
  return keystoneLevel, dungeonID, dungeonName
end

-- Gets the player's character information
local function getPlayerCharacterInfo()
  local name, _ = UnitName("player")
  local class, _, _ = UnitClass("player")
  local race, _, raceID = UnitRace("player")
  local faction = C_CreatureInfo.GetFactionInfo(raceID)["name"]
  local realm = GetRealmName()
  return name, class, race, faction, realm
end

-- psvm
local function handle_test()
  local _, _ = findKeystoneInBags() -- no real use for this atm
  local keystoneLevel, dungeonID, dungeonName = getPlayerKeystone()
  local pName, pClass, pRace, pFaction, pRealm = getPlayerCharacterInfo()

  print(keystoneLevel, dungeonID, dungeonName)
  print(pName, pClass, pRace, pFaction, pRealm)

  print("wcyd")
end

SlashCmdList["TEST"] = handle_test