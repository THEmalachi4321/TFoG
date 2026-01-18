
SMODS.Joker{ --007n7
    key = "_007n7",
    config = {
        extra = {
            mult0 = 10,
            chips0_min = NaN,
            chips0_max = 25
        }
    },
    loc_txt = {
        ['name'] = '007n7',
        ['text'] = {
            [1] = '{C:red}+10{} Mult.',
            [2] = 'Picks a random amount of {C:blue}Chips{} to add.',
            [3] = '{C:blue}(+1-25){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
                mult = 10,
                extra = {
                    chips = pseudorandom('RANGE:1|25', 1, 25),
                    colour = G.C.CHIPS
                }
            }
        end
    end
}