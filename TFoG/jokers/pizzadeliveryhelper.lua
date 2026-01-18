
SMODS.Joker{ --Pizza Delivery Helper
    key = "pizzadeliveryhelper",
    config = {
        extra = {
            chips0 = 100,
            odds = 16
        }
    },
    loc_txt = {
        ['name'] = 'Pizza Delivery Helper',
        ['text'] = {
            [1] = '{C:blue}+100{} Chips.',
            [2] = '{C:green}#1# in #2#{} chance to create a random {C:attention}Tag{}.',
            [3] = '{C:inactive}(Summoned by c00lkidd.){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = "tfog_summon",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_tfog_pizzadeliveryhelper') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                return {
                    chips = 100
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_625d92a1', 1, card.ability.extra.odds, 'j_tfog_pizzadeliveryhelper', false) then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                                    local tag = Tag(selected_tag)
                                    if tag.name == "Orbital Tag" then
                                        local _poker_hands = {}
                                        for k, v in pairs(G.GAME.hands) do
                                            if v.visible then
                                                _poker_hands[#_poker_hands + 1] = k
                                            end
                                        end
                                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                                    end
                                    tag:set_ability()
                                    add_tag(tag)
                                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Created Tag!", colour = G.C.GREEN})
                        end
                        return true
                    end
                }
            end
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_tfog_pizzadeliveryhelper" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_tfog_pizzadeliveryhelper" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end