
SMODS.Joker{ --Veeronica
    key = "veeronica",
    config = {
        extra = {
            hand_size0 = 2,
            discards0 = 1,
            hand_size = 2,
            discards = 1,
            odds = 4,
            mult0 = 35
        }
    },
    loc_txt = {
        ['name'] = 'Veeronica',
        ['text'] = {
            [1] = 'When bought, {C:attention}+2{} Hand Size, {C:red}-1{} Discard.',
            [2] = '{C:green}#1# in #2#{} chance to perform a trick,',
            [3] = 'adding {C:red}+35{} Mult.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = "tfog_moderate",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_veeronica') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
            return {
                
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." Hand Limit", colour = G.C.BLUE})
                    
                    G.hand:change_size(2)
                    return true
                end,
                extra = {
                    
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(1).." Discards", colour = G.C.RED})
                        
                        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
                        ease_discard(-1)
                        
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
        if context.selling_self  then
            return {
                
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(2).." Hand Limit", colour = G.C.BLUE})
                    
                    G.hand:change_size(-2)
                    return true
                end,
                extra = {
                    
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Discards", colour = G.C.GREEN})
                        
                        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                        ease_discard(1)
                        
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_64a5cb35', 1, card.ability.extra.odds, 'j_tfog_veeronica', false) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tfog_veeronicatrick")
                            SMODS.calculate_effect({message = "Trick!"}, card)
                            return true
                        end,
                    }))
                    SMODS.calculate_effect({mult = 35}, card)
                end
            end
        end
    end
}