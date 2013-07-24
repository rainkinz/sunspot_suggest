module SpellcheckHelper
   
  # TODO: Need a better way to build up suggestions
  def stub_spellcheck(suggestions)
    connection.response = {
      'spellcheck' => {
        'suggestions' => suggestions
      }
    }
    
    if connection.response['responseHeader'].nil?
      connection.response['responseHeader'] = {}
    end


  end

{"suggestions"=>
  [
    "perfrm",
    {
      "numFound"=>3,
      "startOffset"=>14,
      "endOffset"=>20,
      "origFreq"=>0,
      "suggestion"=>
        [
          {"word"=>"perform", "freq"=>4},
          {"word"=>"performed", "freq"=>1},
          {"word"=>"performance", "freq"=>3}
        ]
    },
   
    "hvc",
    {
      "numFound"=>2,
      "startOffset"=>21,
      "endOffset"=>24,
      "origFreq"=>0,
      "suggestion"=>[
        {"word"=>"hvac", "freq"=>4}, 
        {"word"=>"have", "freq"=>5}
      ]
    },

   "correctlySpelled", false,

   "collation",
   [
     "collationQuery", "markup_texts:(perform hvac)",
      "hits", 4,
      "misspellingsAndCorrections", ["perfrm", "perform", "hvc", "hvac"]
   ],
   
   "collation",
   [
      "collationQuery", "markup_texts:(performed hvac)",
      "hits", 4,
      "misspellingsAndCorrections", ["perfrm", "performed", "hvc", "hvac"]
   ]
  ]
}


end

