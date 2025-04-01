SMODS.Atlas({
    key = 'TFoGJokers',
    path = 'TFoGJokers.png',
    px = '71',
    py = '95'
})

SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})

-- JOKERS

SMODS.Joker { -- Noob
  key = 'noob',
  loc_txt = {
    name = 'Noob',
    text = {
      'Every 3 rounds, turn a random',
      'card held in hand into a',
      '{C:attention}Stone Card{}.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 1,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 0, y = 0 },
  cost = 4,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Two Time
  key = 'twotime',
  loc_txt = {
    name = 'Two Time',
    text = {
      'Doubles the next consumable purchased',
      'in the shop before destroying itself.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 2,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 1, y = 0 },
  cost = 6,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Chance
  key = 'chance',
  loc_txt = {
    name = 'Chance',
    text = {
      '{X:mult:,C:white}X2{} Mult.',
      'On final hand of round, {C:green}1 in 4{} chance',
      'of turning every card in hand to an',
      '{C:attention}Ace of Spades{} before destroying itself.'
    }
  },
  config = { extra = { mult = 2 } },
  rarity = 4,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 2, y = 0 },
  cost = 10,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Elliot
  key = 'elliot',
  loc_txt = {
    name = 'Elliot',
    text = {
      'Adds one extra card to deck each round.',
      '{C:green}1 in 4{} chance {C:attention}Foil{}, {C:green}1 in 8{} chance {C:attention}Holographic{}, {C:green}1 in 16{} chance {C:attention}Polychrome{}.',
      '{C:red} ACTIVATES 5 TIMES BEFORE BEING CONSUMED.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 1,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 3, y = 0 },
  cost = 4,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Guest 1337
  key = 'guest1337',
  loc_txt = {
    name = 'Guest 1337',
    text = {
      'After defeating a {C:attention}Boss Blind{}, destroy a random',
      '{C:blue}Common{} Joker and gain{C:money} $3{}.',
      '{C:green}1 in 4{} chance to upgrade an',
      '{C:green}Uncommon{} Joker to a Random {C:red}Rare{} Joker.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 3,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 4, y = 0 },
  cost = 10,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- 007n7
  key = '007n7',
  loc_txt = {
    name = '007n7',
    text = {
      'At the start of round, {C:green}1 in 8{} chance of',
      'cloning one of your cards held in hand,',
      'taking 1/2 of the chips of chosen card.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 3,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 0, y = 1 },
  cost = 10,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Shedletsky
  key = 'shedletsky',
  loc_txt = {
    name = 'Shedletsky',
    text = {
      '{C:green}1 in 16{} chance to destroy a random',
      'Joker, (excluding other survivors), giving',
      '{X:mult:,C:white}x2{} Mult and {C:blue}+100 Chips{} to this Joker.',
      '{C:inactive} (Does not stack.)'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 3,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 1, y = 1 },
  cost = 10,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}

SMODS.Joker { -- Dusekkar
  key = 'dusekkar',
  loc_txt = {
    name = 'Dusekkar',
    text = {
      'Removes debuff from 1 random debuffed card.',
      'If there is no debuff, {C:blue}+10 Chips{}.'
    }
  },
  config = { extra = { repetitions = 1 } },
  rarity = 3,
  atlas = 'TFoGJokers',
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 2, y = 1 },
  cost = 10,
  discovered = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if next(context.poker_hands['Straight']) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          card = card,
        }
      end
    end
  end
}