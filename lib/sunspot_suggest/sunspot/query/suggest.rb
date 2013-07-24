module Sunspot
  module Query

    class Suggest < Connective::Conjunction
      attr_accessor :options

      def initialize(opts = {})
        @options = opts
      end

      def to_params
        opts = {}
        @options.each do |key, val|
          opts['spellcheck.' + Sunspot::Util.method_case(key)] = val
        end

        {
          :spellcheck => true,
          :rows => 0,
          'spellcheck.count' => 10,
        }.merge(opts)
      end

    end

  end

end
