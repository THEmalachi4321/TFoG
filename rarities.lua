SMODS.Rarity {
    key = "cheap",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.7,
    badge_colour = HEX('4a90e2'),
    loc_txt = {
        name = "Cheap"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "moderate",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.2,
    badge_colour = HEX('417505'),
    loc_txt = {
        name = "Moderate"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "expensive",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.1,
    badge_colour = HEX('d0021b'),
    loc_txt = {
        name = "Expensive"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "summon",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('000000'),
    loc_txt = {
        name = "Summon"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "milestone_i",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('f5bd23'),
    loc_txt = {
        name = "Milestone I"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "milestone_ii",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('f5bd23'),
    loc_txt = {
        name = "Milestone II"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "summon_msii",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('000000'),
    loc_txt = {
        name = "Summon (MSII)"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}