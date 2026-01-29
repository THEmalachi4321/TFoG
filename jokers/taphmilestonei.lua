
SMODS.Joker{ --Taph - Milestone I
    key = "taphmilestonei",
    config = {
        extra = {
            currentmoney = 0,
            xmult0 = 1.75
        }
    },
    loc_txt = {
        ['name'] = 'Taph - Milestone I',
        ['text'] = {
            [1] = 'Any cards that score will give',
            [2] = '{C:red}+1.15{} Mult for every {C:money}$1{} you have.',
            [3] = '{C:inactive}(Currently: {C:red}+#1#{} {C:inactive}Mult){}',
            [4] = 'If you have less than 5 Jokers, {X:mult,C:white}x1.75{} Mult.',
            [5] = 'At the end of the round, destroy Joker to the left.',
            [6] = ''
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}100,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 3,
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
        
        return {vars = {((G.GAME.dollars or 0)) * 1.15}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(#G.jokers.cards) < to_big(5) then
                return {
                    Xmult = 1.75
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tfog_subspace")
                    SMODS.calculate_effect({message = "BOOM!"}, card)
                    return true
                end,
            }))
            return {
                func = function()
                    local my_pos = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            my_pos = i
                            break
                        end
                    end
                    local target_joker = nil
                    if my_pos and my_pos > 1 then
                        local joker = G.jokers.cards[my_pos - 1]
                        if not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            target_joker = joker
                        end
                    end
                    
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
        if context.individual and context.cardarea == G.play  then
            return {
                mult = (G.GAME.dollars) * 1.15
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips >= to_big(100000)
        end
        return false
    end
}