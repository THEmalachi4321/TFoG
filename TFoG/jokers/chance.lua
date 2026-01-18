
SMODS.Joker{ --Chance
    key = "chance",
    config = {
        extra = {
            odds = 2,
            odds2 = 4,
            odds3 = 8,
            dollars0 = 3,
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Chance',
        ['text'] = {
            [1] = 'With each discard, {C:green}#1# in #2#{} chance to gain {C:money}$3{},',
            [2] = '{C:green}#3# in #4#{} chance to lose {C:money}$5{}. {C:green}#5# in #6#{} chance that',
            [3] = 'this Joker will be destroyed.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "tfog_expensive",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_chance')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_tfog_chance')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds3, 'j_tfog_chance')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3}}
    end,
    
    calculate = function(self, card, context)
        if context.pre_discard  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_8f1f20be', 1, card.ability.extra.odds, 'j_tfog_chance', false) then
                    SMODS.calculate_effect({
                        func = function()
                            
                            local current_dollars = G.GAME.dollars
                            local target_dollars = G.GAME.dollars + 3
                            local dollar_value = target_dollars - current_dollars
                            ease_dollars(dollar_value)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(3), colour = G.C.MONEY})
                            return true
                        end}, card)
                    end
                    if SMODS.pseudorandom_probability(card, 'group_1_9261ebbe', 1, card.ability.extra.odds2, 'j_tfog_chance', false) then
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
                        if SMODS.pseudorandom_probability(card, 'group_2_187e7122', 1, card.ability.extra.odds3, 'j_tfog_chance', false) then
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
            end
        }