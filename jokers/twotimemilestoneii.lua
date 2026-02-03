
SMODS.Joker{ --Two Time - Milestone II
    key = "twotimemilestoneii",
    config = {
        extra = {
            _2sinhand = 0,
            blind_size0 = 0.6
        }
    },
    loc_txt = {
        ['name'] = 'Two Time - Milestone II',
        ['text'] = {
            [1] = 'When {C:attention}Boss{} Blind is selected, the requirements',
            [2] = 'needed is cut to 60%.',
            [3] = '{C:red}+5{} Mult for every card that has a rank of 2.',
            [4] = '{C:inactive}(Currently: {C:red}+#1#{}{C:inactive} Mult){}{}',
            [5] = 'Sell this card to transform him to his second life.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$200{}.'
        }
    },
    pos = {
        x = 1,
        y = 4
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
        
    return {vars = {(((function() local count = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id == 2 then count = count + 1 end end; return count end)() or 0)) * 5}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            if G.GAME.blind.boss then
                return {
                    
                    func = function()
                        if G.GAME.blind.in_blind then
                            
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(0.6).." Blind Size", colour = G.C.GREEN})
                            G.GAME.blind.chips = G.GAME.blind.chips * 0.6
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.HUD_blind:recalculate()
                            return true
                        end
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
            mult = ((function() local count = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id == 2 then count = count + 1 end end; return count end)()) * 5
            }
        end
        if context.selling_self  then
            return {
                func = function()
                    
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_tfog_twotimemilestoneii_life2' })
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
    end,
    check_for_unlock = function(self,args)
        if args.type == "round_win" then
            local count = 0
            return G.GAME.dollars > to_big(200)
        end
        return false
    end
}