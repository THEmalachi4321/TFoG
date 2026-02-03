
SMODS.Joker{ --Guest 1337 - Milestone II
    key = "guest1337milestoneii",
    config = {
        extra = {
            odds = 3,
            mult0 = 20,
            dollars0 = 5,
            odds2 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Guest 1337 - Milestone II',
        ['text'] = {
            [1] = '{C:red}+20{} Mult.',
            [2] = 'After defeating a {C:attention}Boss{} Blind, gain {C:money}$10{} and',
            [3] = '{C:green}#1# in #2#{} chance to create a Random Joker.',
            [4] = '{C:green}#1# in #2#{} chance to prevent death',
            [5] = 'if you don\'t exceed the Blind Goal.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}1,000,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = "tfog_milestone_ii",
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_guest1337milestoneii')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_tfog_guest1337milestoneii')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e872f359', 1, card.ability.extra.odds, 'j_tfog_guest1337milestoneii', false) then
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
                mult = 20
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
                        local target_dollars = G.GAME.dollars + 5
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
        if context.end_of_round and context.game_over and context.main_eval  then
            if to_big(G.GAME.chips / G.GAME.blind.chips) < to_big(1) then
                if SMODS.pseudorandom_probability(card, 'group_0_03da7390', 1, card.ability.extra.odds, 'j_tfog_guest1337milestoneii', false) then
                    SMODS.calculate_effect({saved = true}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_saved_ex'), colour = G.C.RED})
                end
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(1000000)
        end
        return false
    end
}