
SMODS.Joker{ --Dispenser
    key = "dispenser",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Dispenser',
        ['text'] = {
            [1] = '{s:1.5}Passive Joker{}',
            [2] = '{C:inactive}(Does nothing.){}',
            [3] = 'Gives the ability for {C:attention}Builderman{} to add',
            [4] = '{C:blue}Chips{} for every free Joker Slot, every hand.',
            [5] = '{}{C:blue}Chips{} amount is dependant on each version.',
            [6] = '{C:inactive}(Summoned by Builderman.){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    cost = 6,
    rarity = "tfog_summon",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.selling_self  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_explode")
                    
                    return true
                end,
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_tfog_dispenser" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_tfog_dispenser" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end