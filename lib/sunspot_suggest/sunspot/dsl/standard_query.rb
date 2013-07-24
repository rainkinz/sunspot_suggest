module Sunspot
  module DSL #:nodoc:

    class StandardQuery
      def suggest(options = {})
        @query.suggest(options)
      end

      def spellcheck(options = {})
        @query.spellcheck(options)
      end
    end

  end
end
