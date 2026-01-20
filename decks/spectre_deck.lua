
SMODS.Back {
    key = 'spectre_deck',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            hand_size0 = 5
        },
    },
    loc_txt = {
        name = 'Spectre Deck',
        text = {
            [1] = 'Start with {C:attention}2{} {C:common}Cheap{} Jokers.',
            [2] = '{C:attention}+3{} Joker Slots.',
            [3] = '{C:red}Starting hand size is 5.{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 3
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', rarity = 'tfog_cheap' })
                    if new_joker then
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', rarity = 'tfog_cheap' })
                    if new_joker then
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
        return {
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    
                    
                    local current_hand_size = (G.hand.config.card_limit or 0)
                    local target_hand_size = 5
                    local difference = target_hand_size - current_hand_size
                    G.hand:change_size(difference)
                    return true
                end
            }))
        }
    end
}