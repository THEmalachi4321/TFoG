SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {1,29,39,15,6,18,42,20,46,4,9,12,25,28,34,37,32,23,5,33,14,2,30,40,16,19,21,13,35,7,43,10,26,24,3,31,41,17,22,8,36,44,45,11,27,38}

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #jokerIndexList do
        local file_name = files[jokerIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end


local deckIndexList = {1}

local function load_decks_folder()
    local mod_path = SMODS.current_mod.path
    local decks_path = mod_path .. "/decks"
    local files = NFS.getDirectoryItemsInfo(decks_path)
    for i = 1, #deckIndexList do
        local file_name = files[deckIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("decks/" .. file_name))()
        end
    end
end

local function load_rarities_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("rarities.lua"))()
end

load_rarities_file()

local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
assert(SMODS.load_file("sounds.lua"))()
load_jokers_folder()
load_decks_folder()
SMODS.ObjectType({
    key = "tfog_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "tfog_tfog_jokers",
    cards = {
        ["j_tfog__007n7"] = true,
        ["j_tfog__007n7milestonei"] = true,
        ["j_tfog__007n7milestoneii"] = true,
        ["j_tfog__1x1x1x1"] = true,
        ["j_tfog_builderman"] = true,
        ["j_tfog_buildermanmilestonei"] = true,
        ["j_tfog_buildermanmilestoneii"] = true,
        ["j_tfog_c00lkidd"] = true,
        ["j_tfog_c00lkiddmilestonei"] = true,
        ["j_tfog_c00lkiddmilestoneii"] = true,
        ["j_tfog_chance"] = true,
        ["j_tfog_chancemilestonei"] = true,
        ["j_tfog_dusekkar"] = true,
        ["j_tfog_dusekkarmilestonei"] = true,
        ["j_tfog_dusekkarmilestoneii"] = true,
        ["j_tfog_elliot"] = true,
        ["j_tfog_elliotmilestonei"] = true,
        ["j_tfog_guest1337"] = true,
        ["j_tfog_guest1337milestonei"] = true,
        ["j_tfog_guest1337milestoneii"] = true,
        ["j_tfog_guest666"] = true,
        ["j_tfog_guest666milestonei"] = true,
        ["j_tfog_johndoe"] = true,
        ["j_tfog_johndoemilestonei"] = true,
        ["j_tfog_johndoemilestoneii"] = true,
        ["j_tfog_noli"] = true,
        ["j_tfog_noob"] = true,
        ["j_tfog_noobmilestonei"] = true,
        ["j_tfog_noobmilestoneii"] = true,
        ["j_tfog_nosferatu"] = true,
        ["j_tfog_shedletsky"] = true,
        ["j_tfog_shedletskymilestonei"] = true,
        ["j_tfog_shedletskymilestoneii"] = true,
        ["j_tfog_slasher"] = true,
        ["j_tfog_taph"] = true,
        ["j_tfog_taphmilestonei"] = true,
        ["j_tfog_taphmilestoneii"] = true,
        ["j_tfog_twotime"] = true,
        ["j_tfog_twotimemilestonei"] = true,
        ["j_tfog_twotimemilestoneii"] = true,
        ["j_tfog_twotimemilestoneii_life2"] = true,
        ["j_tfog_veeronica"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end