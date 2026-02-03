
SMODS.Joker{ --John Doe - Milestone II
    key = "johndoemilestoneii",
    config = {
        extra = {
            chips0 = 200,
            xmult0 = 0.5,
            chips = 100,
            xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'John Doe - Milestone II',
        ['text'] = {
            [1] = '{C:blue}+200{} Chips and {X:red,C:white}x0.5{} Mult.',
            [2] = 'If you have more than {C:money}$50{},',
            [3] = '{C:blue}+100{} Chips and {X:red,C:white}x2{} Mult.',
            [4] = 'After defeating a {C:attention}Boss{} Blind,',
            [5] = 'destroys a random Joker.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}1,500,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 4,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 14,
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
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (to_big(G.GAME.dollars) >= to_big(50)) then
                return {
                    chips = 200,
                    extra = {
                        Xmult = 0.5
                    }
                }
            elseif to_big(G.GAME.dollars) >= to_big(50) then
                return {
                    chips = 100,
                    extra = {
                        Xmult = 2
                    }
                }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            return {
                func = function()
                    local destructable_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            table.insert(destructable_jokers, joker)
                        end
                    end
                    local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                    
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
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(1500000)
        end
        return false
    end
}