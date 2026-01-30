
SMODS.Joker{ --Taph - Milestone II
    key = "taphmilestoneii",
    config = {
        extra = {
            currentmoney = 0,
            xmult0 = 1.75,
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'Taph - Milestone II',
        ['text'] = {
            [1] = 'Any cards that score will give',
            [2] = '{C:red}+1.5{} Mult for every {C:money}$1{} you have.',
            [3] = '{C:inactive}(Currently: {C:red}+#1#{} {C:inactive}Mult)',
            [4] = '{C:green}#2# in #3#{} chance to spawn a',
            [5] = 'Subspace Tripmine every round.',
            [6] = ''
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$150{}.'
        }
    },
    pos = {
        x = 5,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_taphmilestoneii') 
        return {vars = {((G.GAME.dollars or 0)) * 1.5, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(#G.jokers.cards) < to_big(5) then
                return {
                    Xmult = 1.75
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            return {
                mult = (G.GAME.dollars) * 1.5
            }
        end
        if context.setting_blind  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_34cb1b5a', 1, card.ability.extra.odds, 'j_tfog_taphmilestoneii', false) then
                    SMODS.calculate_effect({func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_tfog_subspacetripminemsii' })
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
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return G.GAME.dollars > to_big(150)
        end
        return false
    end
}