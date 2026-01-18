
SMODS.Joker{ --Builderman - Milestone I
    key = "buildermanmilestonei",
    config = {
        extra = {
            dollars0 = 10,
            pb_p_dollars_51282158 = 2,
            odds = 6,
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Builderman - Milestone I',
        ['text'] = {
            [1] = 'All scoring cards gain {C:money}$2{}. {C:green}#1# in #2#{}',
            [2] = 'chance to retrigger scoring cards twice.',
            [3] = 'After defeating a {C:attention}Boss{} Blind,',
            [4] = 'exchanges {C:money}$10{} for a random {C:planet}Planet{} card.',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}150,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_buildermanmilestonei') 
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
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + 2
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MONEY }, card = card
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_6bb431ff', 1, card.ability.extra.odds, 'j_tfog_buildermanmilestonei', false) then
                            
                            return {repetitions = 2}
                        end
                        return true
                    end
                }
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(150000)
        end
        return false
    end
}