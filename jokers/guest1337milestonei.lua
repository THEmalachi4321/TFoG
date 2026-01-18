
SMODS.Joker{ --Guest 1337 - Milestone I
    key = "guest1337milestonei",
    config = {
        extra = {
            odds = 4,
            mult0 = 10,
            chips0 = 35,
            dollars0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'Guest 1337 - Milestone I',
        ['text'] = {
            [1] = '{C:red}+10{} Mult and {C:blue}+35{} Chips.',
            [2] = 'After defeating a {C:attention}Boss{} Blind, gain {C:money}$5{} and',
            [3] = '{C:green}#1# in #2#{} chance to create a Random Joker.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}75,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_guest1337milestonei') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e872f359', 1, card.ability.extra.odds, 'j_tfog_guest1337milestonei', false) then
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
                mult = 10,
                extra = {
                    chips = 35,
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
                        local target_dollars = G.GAME.dollars + 5
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(75000)
        end
        return false
    end
}