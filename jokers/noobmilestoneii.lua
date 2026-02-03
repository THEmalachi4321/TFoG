
SMODS.Joker{ --Noob - Milestone II
    key = "noobmilestoneii",
    config = {
        extra = {
            mult0 = 11,
            chips0 = 40
        }
    },
    loc_txt = {
        ['name'] = 'Noob - Milestone II',
        ['text'] = {
            [1] = '{C:red}+10{} Mult and {C:blue}+40{} Chips.',
            [2] = 'When first hand is drawn in every',
            [3] = 'round, create 2 {C:attention}Stone{} Cards and 1',
            [4] = 'card with a random Seal.'
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
    cost = 9,
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
        if context.first_hand_drawn  then
            return {
                func = function()
                    local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.m_stone
                    }, G.discard, true, false, nil, true)
                    
                    
                    
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    base_card.playing_card = G.playing_card
                    table.insert(G.playing_cards, base_card)
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(base_card)
                            base_card:start_materialize()
                            SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                            return true
                        end
                    }))
                end,
                message = "Slateskin!",
                extra = {
                    func = function()
                        local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                        local base_card = create_playing_card({
                            front = card_front,
                            center = G.P_CENTERS.m_stone
                        }, G.discard, true, false, nil, true)
                        
                        
                        
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        base_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, base_card)
                        
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.hand:emplace(base_card)
                                base_card:start_materialize()
                                SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                                return true
                            end
                        }))
                    end,
                    message = "Added Card to Hand!",
                    colour = G.C.GREEN,
                    extra = {
                        func = function()
                            local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                            local base_card = create_playing_card({
                                front = card_front,
                                center = G.P_CENTERS.c_base
                            }, G.discard, true, false, nil, true)
                            
                            base_card:set_seal(pseudorandom_element({'Gold','Red','Blue','Purple'}, pseudoseed('add_card_hand_seal')), true)
                            
                            
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            base_card.playing_card = G.playing_card
                            table.insert(G.playing_cards, base_card)
                            
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.hand:emplace(base_card)
                                    base_card:start_materialize()
                                    SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                                    return true
                                end
                            }))
                        end,
                        message = "Added Card to Hand!",
                        colour = G.C.GREEN
                    }
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 11,
                extra = {
                    chips = 40,
                    colour = G.C.CHIPS
                }
            }
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