
SMODS.Joker{ --Two Time - Milestone I
    key = "twotimemilestonei",
    config = {
        extra = {
            odds = 45,
            blind_size0 = 0.65
        }
    },
    loc_txt = {
        ['name'] = 'Two Time - Milestone I',
        ['text'] = {
            [1] = 'When {C:attention}Boss{} Blind is selected, the requirements',
            [2] = 'needed is cut to 65%.',
            [3] = 'While playing the game as intended,',
            [4] = '{C:green}#1# in #2#{} chance for this Joker to create',
            [5] = 'a Random{C:dark_edition} Negative{} {C:spectral}Spectral{} card.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$100{}.'
        }
    },
    pos = {
        x = 9,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_twotimemilestonei') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if (context.end_of_round or context.reroll_shop or context.buying_card or
            context.selling_card or context.ending_shop or context.starting_shop or 
            context.ending_booster or context.skipping_booster or context.open_booster or
            context.skip_blind or context.before or context.pre_discard or context.setting_blind or
        context.using_consumeable)   then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_12a0fbcf', 1, card.ability.extra.odds, 'j_tfog_twotimemilestonei', false) then
                    SMODS.calculate_effect({func = function()
                        
                        for i = 1, 1 do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                    end
                                    
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', edition = 'e_negative', })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        return true
                    end}, card)
                end
            end
        end
        if context.setting_blind  then
            if G.GAME.blind.boss then
                return {
                    
                    func = function()
                        if G.GAME.blind.in_blind then
                            
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(0.65).." Blind Size", colour = G.C.GREEN})
                            G.GAME.blind.chips = G.GAME.blind.chips * 0.65
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.HUD_blind:recalculate()
                            return true
                        end
                    end
                }
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return G.GAME.dollars > to_big(100)
        end
        return false
    end
}