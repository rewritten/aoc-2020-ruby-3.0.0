# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D22
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 953
      solution part_two: 1289

      # state indices:
      PLAYER_HP = 0
      PLAYER_MANA = 1
      PLAYER_POISONING = 2
      PLAYER_RECHARGING = 3
      PLAYER_SHIELDED = 4
      PLAYER_BLEED = 5
      BOSS_HP = 6
      MANA_SPENT = 7

      SPELL_FLAGS = {
        poison: ->{ _1[PLAYER_POISONING].zero? },
        recharge: ->{ _1[PLAYER_RECHARGING].zero? },
        shield: ->{ _1[PLAYER_SHIELDED].zero? },
        magic_missile: proc { true },
        drain: proc { true }
      }.freeze

      Player = Struct.new(:hp, :mana, :damage, :armor, :shield, :poison, :recharge) do
        def magic_missile = 0

        def drain = 0
      end

      SPELLS = { magic_missile: 53, drain: 73, shield: 113, poison: 173, recharge: 229 }.freeze

      def initialize(data)
        @data = data
      end

      def part_one
        game = [50, 500, 0, 0, 0, 0, 55, 0]
        @best = nil

        play(game)

        @best
      end

      def part_two
        game = [50, 500, 0, 0, 0, 1, 55, 0]
        @best = nil

        play(game)

        @best
      end

      private

      def apply_effects!(game)
        game[BOSS_HP] -= 3 if game[PLAYER_POISONING].positive?
        game[PLAYER_MANA] += 101 if game[PLAYER_RECHARGING].positive?
        game[PLAYER_POISONING] -= 1 if game[PLAYER_POISONING].positive?
        game[PLAYER_RECHARGING] -= 1 if game[PLAYER_RECHARGING].positive?
        game[PLAYER_SHIELDED] -= 1 if game[PLAYER_SHIELDED].positive?
      end

      def cast!(game, spell)
        case spell
        when :magic_missile
          game[BOSS_HP] -= 4
        when :drain
          game[PLAYER_HP] += 2
          game[BOSS_HP] -= 2
        when :shield
          game[PLAYER_SHIELDED] = 6
        when :poison
          game[PLAYER_POISONING] = 6
        when :recharge
          game[PLAYER_RECHARGING] = 5
        end
      end

      def win?(game)
        return if game[BOSS_HP].positive?

        @best = [game[MANA_SPENT], @best].compact.min
      end

      def suboptimal?(game)
        return unless @best

        game[MANA_SPENT] > @best
      end

      def play(game)
        game[PLAYER_HP] -= game[PLAYER_BLEED]

        return if suboptimal?(game)
        return unless game[PLAYER_HP].positive?

        apply_effects!(game)
        return if win? game

        SPELLS
          .each do |spell, cost|
            next if game[PLAYER_MANA] < cost
            next unless SPELL_FLAGS[spell][game]

            subgame = game.dup

            # cast the spell
            cast! subgame, spell
            subgame[MANA_SPENT] += cost
            subgame[PLAYER_MANA] -= cost
            break if win? subgame

            apply_effects!(subgame)
            break if win? subgame

            # be attacked by opponent
            subgame[PLAYER_HP] -= subgame[PLAYER_SHIELDED].zero? ? 8 : 1

            # next turn
            play(subgame) if subgame[PLAYER_HP].positive?
          end
      end
    end
  end
end
