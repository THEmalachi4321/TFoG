
SMODS.Joker{ --007n7 - Milestone I
    key = "_007n7milestonei",
    config = {
        extra = {
            mult0 = 15,
            chips0_min = NaN,
            chips0_max = 35
        }
    },
    loc_txt = {
        ['name'] = '007n7 - Milestone I',
        ['text'] = {
            [1] = '{C:red}+15{} Mult.',
            [2] = 'Picks a random amount of {C:blue}Chips{} to add.',
            [3] = '{C:blue}(+1-35){}'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$50{}.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "tfog_milestone_i",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 15,
                extra = {
                    chips = pseudorandom('RANGE:1|35', 1, 35),
                    colour = G.C.CHIPS
                }
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return G.GAME.dollars > to_big(50)
        end
        return false
    end
}