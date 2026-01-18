
SMODS.Joker{ --Guest 1337
    key = "guest1337",
    config = {
        extra = {
            odds = 6,
            mult0 = 5,
            chips0 = 25,
            dollars0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Guest 1337',
        ['text'] = {
            [1] = '{C:red}+5{} Mult and {C:blue}+25{} Chips.',
            [2] = 'After defeating a {C:attention}Boss{} Blind, gain {C:money}$3{} and',
            [3] = '{C:green}#1# in #2#{} chance to create a Random Joker.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_guest1337') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e872f359', 1, card.ability.extra.odds, 'j_tfog_guest1337', false) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tfog_charge")
                            SMODS.calculate_effect({message = "AHHH!"}, card)
                            return true
                        end,
                    }))
                    SMODS.calculate_effect({func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker' })
                                    if joker_card then
                                        
                                        
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end}, card)
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 5,
                extra = {
                    chips = 25,
                    colour = G.C.CHIPS
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tfog_punch")
                        SMODS.calculate_effect({message = "Punch!"}, card)
                        return true
                    end,
                }))
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + 3
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(3), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
    end
}