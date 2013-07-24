require 'spec_helper'

# Check that the responses from solr are parsed correctly by 
# sunspot
describe 'spellcheck', :type => :search do

  context "spellcheck with extended results but no collations" do 
    before(:each) do 
      stub_spellcheck [
      'perform',{
        'numFound'=>3,
        'startOffset'=>0,
        'endOffset'=>7,
        'origFreq'=>4,
        'suggestion'=>[{
            'word'=>'performed',
            'freq'=>1},
          {
            'word'=>'performance',
            'freq'=>3},
          {
            'word'=>'inform',
            'freq'=>2}]},
      'hvac',{
        'numFound'=>1,
        'startOffset'=>8,
        'endOffset'=>12,
        'origFreq'=>4,
        'suggestion'=>[{
            'word'=>'has',
            'freq'=>1}]},
      'correctlySpelled',false
      ]
    end

    it 'creates corrections' do
      result = session.search Article do
        fulltext 'perfrm hvc'
        spellcheck
      end

      spellcheck = result.spellcheck
      collations = spellcheck.collations
      expect(collations.size).to eq(0)

      corrections = spellcheck.suggestions
      expect(corrections.size).to eq(2)
    end

  end

  context "spellcheck with extended results and collations" do 
    before(:each) do 
      stub_spellcheck [
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


    end

    it 'parses the suggestions' do
      result = session.search Article do
        fulltext 'perfrm hvc'
        spellcheck
      end

      spelling_suggestions = result.spellcheck
      collations = spelling_suggestions.collations
      expect(collations.size).to eq(2)
      expect(collations.first.query).to eq('markup_texts:(perform hvac)')
    end

  end

end

