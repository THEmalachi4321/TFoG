
SMODS.Joker{ --Shedletsky - Milestone I
    key = "shedletskymilestonei",
    config = {
        extra = {
            pb_x_mult_6ba64c0e = 0.25,
            odds = 12,
            dollars0_min = NaN,
            dollars0_max = 5
        }
    },
    loc_txt = {
        ['name'] = 'Shedletsky - Milestone I',
        ['text'] = {
            [1] = 'Every hand played gives {C:money}$3-5{}.',
            [2] = 'If any scoring cards are either {C:clubs}Clubs{} or {C:spades}Spades{},',
            [3] = 'add {X:mult,C:white}x0.25{} Mult to those cards. {C:green}#1# in #2#{} chance',
            [4] = 'for those scoring cards to be destroyed.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$50{}.'
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_shedletskymilestonei') 
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
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + 0.25
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_56deeb6f', 1, card.ability.extra.odds, 'j_tfog_shedletskymilestonei', false) then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound("tfog_slash")
                                    SMODS.calculate_effect({message = "Slash!"}, card)
                                    return true
                                end,
                            }))
                            
                        end
                        if SMODS.pseudorandom_probability(card, 'group_1_56deeb6f', 1, card.ability.extra.odds, 'j_tfog_shedletskymilestonei', false) then
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
                    local target_dollars = G.GAME.dollars + pseudorandom('RANGE:3|5', 3, 5)
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(pseudorandom('RANGE:3|5', 3, 5)), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return G.GAME.dollars > to_big(50)
        end
        return false
    end
}