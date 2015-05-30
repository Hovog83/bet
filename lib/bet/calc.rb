require 'bet/bet_calculations/core'
require 'bet/bet_calculations/combinatorial'
require 'bet/bet_calculations/convenience'
# require 'bet/each_way'

module Bet
  class Calc
    extend BetCalculations::Core
    extend BetCalculations::Combinatorial
    extend BetCalculations::Convenience

    DEFAULT_OPTS = { stake: 1, ew: false }
    WIN_PLACE_LOSS_INTEGER = { -1 => :loss, 0 => :place, 1 => :win }

    attr_accessor :returns, :profit

    def initialize(bet_type, opts)
      @returns, @profit, @stake = send(bet_type, opts)
    end

    private
      def win_place_lose?(v)
        v.is_a?(Fixnum) ? WIN_PLACE_LOSS_INTEGER[v] : v
      end

      def c(stake, price)
        stake * price
      end

      def extract_prices(opts_or_prices)
        case opts_or_prices
        when Hash
          opts_or_prices[:prices]
        when Numeric
          [opts_or_prices]
        else
          opts_or_prices
        end
      end

      def parse_opts(opts_or_prices)
        opts_or_prices.is_a?(Hash) ? DEFAULT_OPTS.merge(opts_or_prices) : DEFAULT_OPTS
      end
  end
end