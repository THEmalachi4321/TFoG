
SMODS.Joker{ --Chance - Milestone I
    key = "chancemilestonei",
    config = {
        extra = {
            odds = 2,
            odds2 = 6,
            odds3 = 12,
            dollars0_min = NaN,
            dollars0_max = 5,
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Chance - Milestone I',
        ['text'] = {
            [1] = 'With each discard, {C:green}#1# in #2#{} chance to gain {C:money}$3-5{},',
            [2] = '{C:green}#3# in #4#{} chance to lose {C:money}$5{}. {C:green}#5# in #6#{} chance that',
            [3] = 'this Joker will be destroyed.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$100{}.'
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_chancemilestonei')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_tfog_chancemilestonei')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds3, 'j_tfog_chancemilestonei')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3}}
    end,
    
    calculate = function(self, card, context)
        if context.pre_discard  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_8f1f20be', 1, card.ability.extra.odds, 'j_tfog_chancemilestonei', false) then
                    SMODS.calculate_effect({
                        func = function()
                            
                            local current_dollars = G.GAME.dollars
                            local target_dollars = G.GAME.dollars + pseudorandom('RANGE:3|5', 3, 5)
                            local dollar_value = target_dollars - current_dollars
                            ease_dollars(dollar_value)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(pseudorandom('RANGE:3|5', 3, 5)), colour = G.C.MONEY})
                            return true
                        end}, card)
                    end
                    if SMODS.pseudorandom_probability(card, 'group_1_9261ebbe', 1, card.ability.extra.odds2, 'j_tfog_chancemilestonei', false) then
                        SMODS.calculate_effect({
                            func = function()
                                
                                local current_dollars = G.GAME.dollars
                                local target_dollars = G.GAME.dollars - 5
                                local dollar_value = target_dollars - current_dollars
                                ease_dollars(dollar_value)
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(5), colour = G.C.MONEY})
                                return true
                            end}, card)
                        end
                        if SMODS.pseudorandom_probability(card, 'group_2_187e7122', 1, card.ability.extra.odds3, 'j_tfog_chancemilestonei', false) then
                            SMODS.calculate_effect({func = function()
                                local target_joker = card
                                
                                if target_joker then
                                    target_joker.getting_sliced = true
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            target_joker:explode({G.C.RED}, nil, 1.6)
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Backfire!", colour = G.C.RED})
                                end
                                return true
                            end}, card)
                        end
                    end
                end
            end,
            check_for_unlock = function(self,args)
                if args.type == "win" then
                    local count = 0
                    return G.GAME.dollars > to_big(100)
                end
                return false
            end
        }