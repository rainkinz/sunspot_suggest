module Sunspot

  module Search

    class Spellcheck

      # TODO: Firm up the names of these a bit
      class Collation
        attr_reader :query, :suggestions, :hits

        def initialize(args = {})
          @query = args['collationQuery']
          @hits = args['hits']
          @suggestions = parse_corrections(args['misspellingsAndCorrections'])
        end

        private 

        def parse_corrections(raw)
          suggestions = []
          raw.each_slice(2) do |k, v|
            suggestions << Suggestions.new(k, [Suggestion.new(v)])
          end
          suggestions
        end
      end

      # TODO: Rename this, make it enumerable?
      class Suggestions
        attr_reader :misspelling, :suggestions

        def initialize(misspelling, suggestions)
          @misspelling = misspelling
          # TODO: FIXME
          @suggestions = parse_suggestions(suggestions)
        end

        private

        # TODO: FIXME
        def parse_suggestions(suggestions)
          []
        end
      end

      class Suggestion
        attr_reader :word

        def initialize(word, freq = -1)
          @word = word
          @freq = freq
        end

        def to_s
          @word
        end
      end

      attr_reader :suggestions, :collations
      attr_writer :correctly_spelled

      def initialize
        @suggestions = []
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

      def add_suggestion(word, suggest_values)
        @suggestions << Suggestions.new(word, suggest_values)
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


      def spellcheck_results
        @spellcheck_results = begin
          spellcheck = Spellcheck.new

          raw_suggestions.each_slice(2) do |k, v|
            if k == 'collation'
              spellcheck.add_collation(v)
            elsif k == 'correctlySpelled'
              spellcheck.correctly_spelled = (v == 'true')
            else
              spellcheck.add_suggestion(k, v)
            end
          end
          spellcheck
        end
      end

      private

      def raw_suggestions
        ["spellcheck", "suggestions"].inject(@solr_result) {|h, k| h && h[k]}
      end

    end
  end
end
