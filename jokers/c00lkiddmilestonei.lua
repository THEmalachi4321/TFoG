
SMODS.Joker{ --c00lkidd - Milestone I
    key = "c00lkiddmilestonei",
    config = {
        extra = {
            xmult0 = 5,
            dollars0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'c00lkidd - Milestone I',
        ['text'] = {
            [1] = '{X:red,C:white}x5{} Mult. {C:money}-$5{} every hand played.',
            [2] = 'When {C:attention}Big{} Blind is selected, creates',
            [3] = 'a helper. {C:inactive}(Must have room.){}',
            [4] = 'After defeating a {C:attention}Boss{} Blind,',
            [5] = 'destroys a random Joker.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}250,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 12,
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
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_coolkiddlaugh")
                    
                    return true
                end,
            }))
            return {
                Xmult = 5
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
        if context.before and context.cardarea == G.jokers  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_coolkiddlaugh2")
                    
                    return true
                end,
            }))
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars - 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(5), colour = G.C.MONEY})
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
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(250000)
        end
        return false
    end
}