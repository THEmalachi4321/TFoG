
SMODS.Joker{ --Noob - Milestone I
    key = "noobmilestonei",
    config = {
        extra = {
            mult0 = 5,
            chips0 = 20
        }
    },
    loc_txt = {
        ['name'] = 'Noob - Milestone I',
        ['text'] = {
            [1] = '{C:red}+5{} Mult and {C:blue}+20{} Chips.',
            [2] = 'When first hand is drawn in every',
            [3] = 'round, create a {C:attention}Stone{} Card.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$50{}.'
        }
    },
    pos = {
        x = 2,
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
                message = "Slateskin!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 5,
                extra = {
                    chips = 20,
                    colour = G.C.CHIPS
                }
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