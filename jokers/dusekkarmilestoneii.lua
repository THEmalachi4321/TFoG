
SMODS.Joker{ --Dusekkar - Milestone II
    key = "dusekkarmilestoneii",
    config = {
        extra = {
            odds = 10,
            joker_slots0 = 1,
            odds2 = 2,
            shop_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Dusekkar - Milestone II',
        ['text'] = {
            [1] = 'Every time a Booster Pack is',
            [2] = 'opened, {C:green}#1# in #2#{} chance to',
            [3] = 'gain {C:attention}+1{} Joker Slot.',
            [4] = 'If you have {C:attention}Builderman{}, {C:green}#3# in #4#{} chance',
            [5] = 'to add an extra slot to the shop.'
        },
        ['unlock'] = {
            [1] = 'Win a run with more than {C:money}$150{}.'
        }
    },
    pos = {
        x = 7,
        y = 3
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_dusekkarmilestoneii')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_tfog_dusekkarmilestoneii')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.open_booster  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_59764995', 1, card.ability.extra.odds, 'j_tfog_dusekkarmilestoneii', false) then
                    SMODS.calculate_effect({func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Joker Slot", colour = G.C.DARK_EDITION})
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end}, card)
                end
            end
        end
        if context.starting_shop  then
            if ((function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_tfog_builderman" then 
                        return true
                    end
                end
            end)() or (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_tfog_buildermanmilestonei" then 
                        return true
                    end
                end
            end)() or (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_tfog_buildermanmilestoneii" then 
                        return true
                    end
                end
            end)()) then
                if SMODS.pseudorandom_probability(card, 'group_0_b352fe57', 1, card.ability.extra.odds2, 'j_tfog_dusekkarmilestoneii', false) then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Shop Card", colour = G.C.BLUE})
                            
                            change_shop_size(1)
                            return true
                        end}, card)
                    end
                end
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