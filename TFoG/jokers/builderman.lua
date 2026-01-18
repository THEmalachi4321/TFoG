
SMODS.Joker{ --Builderman
    key = "builderman",
    config = {
        extra = {
            dollars0 = 10,
            pb_p_dollars_51282158 = 0.5,
            odds = 8,
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Builderman',
        ['text'] = {
            [1] = 'All scoring cards gain {C:money}$0.5{}. {C:green}#1# in #2#{}',
            [2] = 'chance to retrigger scoring cards twice.',
            [3] = 'After defeating a {C:attention}Boss{} Blind,',
            [4] = 'exchanges {C:money}$10{} for a random {C:planet}Planet{} card.',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_builderman') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if to_big(G.GAME.dollars) >= to_big(10) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars - 10
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(10), colour = G.C.MONEY})
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.4,
                                    func = function()
                                        play_sound('timpani')
                                        SMODS.add_card({ set = 'Planet', })                            
                                        card:juice_up(0.3, 0.5)
                                        return true
                                    end
                                }))
                            end
                            delay(0.6)
                            
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                            end
                            return true
                        end,
                        colour = G.C.SECONDARY_SET.Planet
                    }
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if true then
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars or 0
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + 0.5
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MONEY }, card = card
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_6bb431ff', 1, card.ability.extra.odds, 'j_tfog_builderman', false) then
                            
                            return {repetitions = 2}
                        end
                        return true
                    end
                }
            end
        end
    end
}