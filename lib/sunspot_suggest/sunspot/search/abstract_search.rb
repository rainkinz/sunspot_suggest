module Sunspot
  module Search

    # TODO: Not sure about this
    class SuggestedResult
      attr_accessor :query, :correctly_spelled, :suggestions
    end


    # TODO: Maybe make this enumerable?
    class SpellingSuggestions

      class Collation
        attr_reader :query, :corrections, :hits

        def initialize(args = {})
          @query = args['collationQuery']
          @hits = args['hits']
          @corrections = parse_corrections(args['misspellingsAndCorrections'])
        end

        private 

        def parse_corrections(raw)
          corrections = []
          raw.each_slice(2) do |k, v|
            corrections << Correction.new(k, v)
          end
          corrections
        end
      end

      class Correction
        attr_reader :misspelling, :correction

        def initialize(misspelling, correction)
          @misspelling = misspelling
          @correction = correction
        end
      end

      attr_reader :corrections, :collations
      attr_writer :correctly_spelled

      def initialize
        @corrections = []
        @collations = []
      end

      def correctly_spelled?
        @correctly_spelled
      end

      def add_collation(collation_values)
        if collation_values.is_a?(Array)
          @collations << Collation.new(Hash[*collation_values])
        else
          raise ArgumentError, "Don't know how to handle collation: #{collation_values}"
        end
      end

    end

    class AbstractSearch

      attr_accessor :solr_result


      def suggested
        raw = raw_suggestions
        return nil unless raw.is_a?(Array)

        s = SuggestedResult.new
        Hash[*raw].each do |k, v|
          if k == 'correctlySpelled'
            s.correctly_spelled = v
          else
            s.query = k
            s.suggestions = v['suggestion']
          end
        end
        s
      end


      def spelling_suggestions
        suggestions = SpellingSuggestions.new

        raw_suggestions.each_slice(2) do |k, v|
          if k == 'collation'
            suggestions.add_collation(v)
          elsif k == 'correctlySpelled'
            suggestions.correctly_spelled = (v == 'true')
          else
            #suggestions_hash[k] = v
          end
        end
        suggestions
      end

      private

      def raw_suggestions
        ["spellcheck", "suggestions"].inject(@solr_result) {|h, k| h && h[k]}
      end

    end
  end
end
