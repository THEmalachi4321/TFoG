
SMODS.Joker{ --Taph
    key = "taph",
    config = {
        extra = {
            currentmoney = 0,
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Taph',
        ['text'] = {
            [1] = 'Any cards that score will give',
            [2] = '{C:red}+0.5{} Mult for every {C:money}$1{} you have.',
            [3] = '{C:inactive}(Currently: {C:red}+#1#{} {C:inactive}Mult){}',
            [4] = 'If you have less than 4 Jokers, {X:mult,C:white}x1.5{} Mult.',
            [5] = 'At the end of the round, destroy Joker to the left.',
            [6] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = "tfog_cheap",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {((G.GAME.dollars or 0)) * 0.5}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(#G.jokers.cards) < to_big(4) then
                return {
                    Xmult = 1.5
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
                mult = (G.GAME.dollars) * 0.5
            }
        end
    end
}