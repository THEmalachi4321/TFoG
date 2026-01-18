
SMODS.Joker{ --Dusekkar
    key = "dusekkar",
    config = {
        extra = {
            odds = 16,
            joker_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Dusekkar',
        ['text'] = {
            [1] = 'Every time a Booster Pack is',
            [2] = 'opened, {C:green}#1# in #2#{} chance to',
            [3] = 'gain {C:attention}+1{} Joker Slot.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_dusekkar') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.open_booster  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_59764995', 1, card.ability.extra.odds, 'j_tfog_dusekkar', false) then
                    SMODS.calculate_effect({func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Joker Slot", colour = G.C.DARK_EDITION})
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end}, card)
                end
            end
        end
    end
}