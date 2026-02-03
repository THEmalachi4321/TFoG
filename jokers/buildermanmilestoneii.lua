
SMODS.Joker{ --Builderman - Milestone II
    key = "buildermanmilestoneii",
    config = {
        extra = {
            freejokerslots = 0,
            pb_p_dollars_51282158 = 2,
            odds = 14
        }
    },
    loc_txt = {
        ['name'] = 'Builderman - Milestone II',
        ['text'] = {
            [1] = 'All scoring cards gain {C:money}$2{}.',
            [2] = 'When the round ends, {C:green}#2# in #3#{}',
            [3] = 'chance to create a Dispenser.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}1,100,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 9,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_buildermanmilestoneii') 
        return {vars = {(((G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and (G.jokers and G.jokers.cards or {}) or {}))) * 15, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars or 0
            context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + 2
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.MONEY }, card = card
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_tfog_dispenser" then 
                        return true
                    end
                end
            end)() then
                return {
                    chips = (((G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and G.jokers.cards or {}))) * 15
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_b3dc7934', 1, card.ability.extra.odds, 'j_tfog_buildermanmilestoneii', false) then
                    SMODS.calculate_effect({func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_tfog_dispenser' })
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
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(1100000)
        end
        return false
    end
}