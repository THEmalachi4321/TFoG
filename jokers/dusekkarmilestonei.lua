
SMODS.Joker{ --Dusekkar - Milestone I
    key = "dusekkarmilestonei",
    config = {
        extra = {
            odds = 12,
            joker_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Dusekkar - Milestone I',
        ['text'] = {
            [1] = 'Every time a Booster Pack is',
            [2] = 'opened, {C:green}#1# in #2#{} chance to',
            [3] = 'gain {C:attention}+1{} Joker Slot.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}125,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 4,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_dusekkarmilestonei') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.open_booster  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_59764995', 1, card.ability.extra.odds, 'j_tfog_dusekkarmilestonei', false) then
                    SMODS.calculate_effect({func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Joker Slot", colour = G.C.DARK_EDITION})
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end}, card)
                end
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(125000)
        end
        return false
    end
}