require 'sunspot_suggest/sunspot/query/suggest'
require 'sunspot_suggest/sunspot/query/spellcheck'
require 'sunspot_suggest/sunspot/query/common_query'

require 'sunspot_suggest/sunspot/search/abstract_search'
require 'sunspot_suggest/sunspot/dsl/standard_query'

module Sunspot
  module Util
    class<<self
      def method_case(string_or_symbol)
        string = string_or_symbol.to_s
        first = true
        string.split('_').map! { |word| word = first ? word : word.capitalize; first = false; word }.join
      end
    end
  end
end


