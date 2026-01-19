
SMODS.Joker{ --Shedletsky
    key = "shedletsky",
    config = {
        extra = {
            pb_x_mult_6ba64c0e = 0.15,
            odds = 8,
            dollars0_min = NaN,
            dollars0_max = 3
        }
    },
    loc_txt = {
        ['name'] = 'Shedletsky',
        ['text'] = {
            [1] = 'Every hand played gives {C:money}$1-3{}.',
            [2] = 'If any scoring cards are either {C:clubs}Clubs{} or {C:spades}Spades{},',
            [3] = 'add {X:mult,C:white}x0.15{} Mult to those cards. {C:green}#1# in #2#{} chance',
            [4] = 'for those scoring cards to be destroyed.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_shedletsky') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs") then
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + 0.15
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_56deeb6f', 1, card.ability.extra.odds, 'j_tfog_shedletsky', false) then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound("tfog_slash")
                                    SMODS.calculate_effect({message = "Slash!"}, card)
                                    return true
                                end,
                            }))
                            
                        end
                        if SMODS.pseudorandom_probability(card, 'group_1_56deeb6f', 1, card.ability.extra.odds, 'j_tfog_shedletsky', false) then
                            context.other_card.should_destroy = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound("tfog_slash")
                                    SMODS.calculate_effect({message = "Slash!"}, card)
                                    return true
                                end,
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + pseudorandom('RANGE:1|3', 1, 3)
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(pseudorandom('RANGE:1|3', 1, 3)), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}