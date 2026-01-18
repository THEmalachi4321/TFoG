
SMODS.Joker{ --Nosferatu
    key = "nosferatu",
    config = {
        extra = {
            Xmultvar = 1,
            odds = 8
        }
    },
    loc_txt = {
        ['name'] = 'Nosferatu',
        ['text'] = {
            [1] = 'When other Jokers trigger, {C:green}#2# in #3#{} chance to',
            [2] = 'destroy a Random Joker, giving this Joker {X:mult,C:white}x0.25{} Mult.',
            [3] = '{C:inactive}(Currently: {X:mult,C:white}x#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "tfog_expensive",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["tfog_tfog_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_nosferatu') 
        return {vars = {card.ability.extra.Xmultvar, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.other_joker  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_9b43055b', 1, card.ability.extra.odds, 'j_tfog_nosferatu', false) then
                    SMODS.calculate_effect({func = function()
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
                    end}, card)
                    SMODS.calculate_effect({func = function()
                        card.ability.extra.Xmultvar = (card.ability.extra.Xmultvar) + 0.25
                        return true
                    end}, card)
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmultvar
            }
        end
    end
}