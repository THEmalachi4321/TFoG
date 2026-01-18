
SMODS.Booster {
    key = 'milestone_i_pack',
    loc_txt = {
        name = "Milestone I Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to {C:attention}3{}',
            [2] = 'Milestone I Jokers.',
            [3] = '{C:inactive}(If none are unlocked, Joker will only appear.){}'
        },
        group_name = "tfog_boosters"
    },
    config = { extra = 3, choose = 1 },
    cost = 10,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'Milestone I',
    group_key = "tfog_boosters",
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            4.95,
            0.05
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('tfog_milestone_i_pack_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
                set = "Joker",
                rarity = "tfog_milestone_i",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "tfog_milestone_i_pack"
            }
        elseif selected_index == 2 then
            return {
                key = "j_joker",
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "tfog_milestone_i_pack"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("d0021b"))
        ease_background_colour({ new_colour = HEX('d0021b'), special_colour = HEX("212121"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    