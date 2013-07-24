module Sunspot
  module Query

    class CommonQuery

      def suggest(options = {})
        @components << Suggest.new(options)
      end

      def spellcheck(options = {})
        @components << Spellcheck.new(options)
      end

    end
  end
end
