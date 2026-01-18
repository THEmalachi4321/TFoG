
SMODS.Joker{ --c00lkidd
    key = "c00lkidd",
    config = {
        extra = {
            joker_slots0 = 2,
            joker_slots = 2,
            xmult0 = 4
        }
    },
    loc_txt = {
        ['name'] = 'c00lkidd',
        ['text'] = {
            [1] = '{X:red,C:white}x4{} Mult. {C:attention}-2{} Joker Slots when bought.',
            [2] = 'When {C:attention}Big{} Blind is selected, creates',
            [3] = 'a helper. {C:inactive}(Must have room.){}',
            [4] = 'After defeating a {C:attention}Boss{} Blind,',
            [5] = 'destroys a random Joker.'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
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
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_hereicome")
                    SMODS.calculate_effect({message = "Here I come!"}, card)
                    return true
                end,
            }))
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(2).." Joker Slot", colour = G.C.RED})
                    G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - 2)
                    return true
                end
            }
        end
        if context.selling_self  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_nofun")
                    
                    return true
                end,
            }))
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." Joker Slot", colour = G.C.DARK_EDITION})
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 2
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_coolkiddlaugh")
                    
                    return true
                end,
            }))
            return {
                Xmult = 4
            }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_gotcha")
                    SMODS.calculate_effect({message = "Gotcha!"}, card)
                    return true
                end,
            }))
            return {
                func = function()
                    local destructable_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            table.insert(destructable_jokers, joker)
                        end
                    end
                    local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                    
                    if target_joker then
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                    end
                    return true
                end
            }
        end
        if context.setting_blind  then
            if G.GAME.blind:get_type() == 'Big' then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tfog_orderup")
                        SMODS.calculate_effect({message = "Order up!"}, card)
                        return true
                    end,
                }))
                return {
                    func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_tfog_pizzadeliveryhelper' })
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
                    end
                }
            end
        end
    end
}