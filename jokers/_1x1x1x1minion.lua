
SMODS.Joker{ --1x1x1x1 Minion
    key = "_1x1x1x1minion",
    config = {
        extra = {
            xmult0 = 1.2
        }
    },
    loc_txt = {
        ['name'] = '1x1x1x1 Minion',
        ['text'] = {
            [1] = '{X:red,C:white}x1.2{} Mult.',
            [2] = '{C:inactive}(Summoned by 1x1x1x1.){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
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
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
            or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_oioi")
                    SMODS.calculate_effect({message = "Oi Oi!"}, card)
                    return true
                end,
            }))
            return {
                Xmult = 1.2
            }
        end
        if context.selling_self  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_miniondeath")
                    
                    return true
                end,
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_tfog__1x1x1x1minion" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_tfog__1x1x1x1minion" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end