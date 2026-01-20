
SMODS.Joker{ --Elliot
    key = "elliot",
    config = {
        extra = {
            odds = 8,
            odds2 = 16,
            odds3 = 32
        }
    },
    loc_txt = {
        ['name'] = 'Elliot',
        ['text'] = {
            [1] = 'Adds cards to deck based on probabilities.',
            [2] = '{C:green}#1# in #2#{} chance {C:attention}Foil{}, {C:green}#3# in #4#{} chance {C:attention}Holographic{},',
            [3] = '{C:green}#5# in #6#{} chance {C:attention}Polychrome{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
        
        local info_queue_0 = G.P_CENTERS["e_foil"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_foil\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_1 = G.P_CENTERS["e_holographic"]
        if info_queue_1 then
            info_queue[#info_queue + 1] = info_queue_1
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_holographic\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_2 = G.P_CENTERS["e_polychrome"]
        if info_queue_2 then
            info_queue[#info_queue + 1] = info_queue_2
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_polychrome\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_elliot')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_tfog_elliot')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds3, 'j_tfog_elliot')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3}}
    end,
    
    calculate = function(self, card, context)
        if context.first_hand_drawn  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_042344a6', 1, card.ability.extra.odds, 'j_tfog_elliot', false) then
                    local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.c_base
                    }, G.discard, true, false, nil, true)
                    
                    
                    base_card:set_edition("e_foil", true)
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            base_card:start_materialize()
                            G.play:emplace(base_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                return true
                            end
                        }))
                        draw_card(G.play, G.deck, 90, 'up')
                        SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                    end}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nice and fresh!", colour = G.C.GREEN})
                end
                if SMODS.pseudorandom_probability(card, 'group_1_2536addb', 1, card.ability.extra.odds2, 'j_tfog_elliot', false) then
                    local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.c_base
                    }, G.discard, true, false, nil, true)
                    
                    
                    base_card:set_edition("e_holo", true)
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            base_card:start_materialize()
                            G.play:emplace(base_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                return true
                            end
                        }))
                        draw_card(G.play, G.deck, 90, 'up')
                        SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                    end}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Added Card!", colour = G.C.GREEN})
                end
                if SMODS.pseudorandom_probability(card, 'group_2_e6ee8780', 1, card.ability.extra.odds3, 'j_tfog_elliot', false) then
                    local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.c_base
                    }, G.discard, true, false, nil, true)
                    
                    
                    base_card:set_edition("e_polychrome", true)
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            base_card:start_materialize()
                            G.play:emplace(base_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                return true
                            end
                        }))
                        draw_card(G.play, G.deck, 90, 'up')
                        SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                    end}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Added Card!", colour = G.C.GREEN})
                end
            end
        end
    end
}