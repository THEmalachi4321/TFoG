
SMODS.Joker{ --Noob
    key = "noob",
    config = {
        extra = {
            mult0 = 3,
            chips0 = 10
        }
    },
    loc_txt = {
        ['name'] = 'Noob',
        ['text'] = {
            [1] = '{C:red}+3{} Mult and {C:blue}+10{} Chips.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = "tfog_cheap",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 3,
                extra = {
                    chips = 10,
                    colour = G.C.CHIPS
                }
            }
        end
    end
}