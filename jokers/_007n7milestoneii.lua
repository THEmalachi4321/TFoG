
SMODS.Joker{ --007n7 - Milestone II
    key = "_007n7milestoneii",
    config = {
        extra = {
            mult0 = 25,
            odds = 8,
            levels0 = 1
        }
    },
    loc_txt = {
        ['name'] = '007n7 - Milestone II',
        ['text'] = {
            [1] = '{C:red}+25{} Mult.',
            [2] = 'After exiting the shop, {C:green}#1# in #2#{} chance to',
            [3] = 'level up a random hand type.'
        },
        ['unlock'] = {
            [1] = 'Score {C:attention}750,000{} or more',
            [2] = '{C:blue}Chips{} in one hand.'
        }
    },
    pos = {
        x = 3,
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
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["e_negative"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_negative\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog__007n7milestoneii') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = 25
            }
        end
        if context.ending_shop  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_8a214ec3', 1, card.ability.extra.odds, 'j_tfog__007n7milestoneii', false) then
                    local available_hands = {}
                    for hand, value in pairs(G.GAME.hands) do
                        if value.visible and value.level >= to_big(1) then
                            table.insert(available_hands, hand)
                        end
                    end
                    local target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand')) or "High Card"
                    level_up_hand(card, target_hand, true, 1)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
                end
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips > to_big(750000)
        end
        return false
    end
}