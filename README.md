# SunspotSpellcheck

Adds spellchecking to sunspot

## Installation

Add this line to your application's Gemfile:

    gem 'sunspot_hierarchical_facets'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sunspot_hierarchical_facets

## Usage

TODO: Write usage instructions here

* Need jar added to solr installation, schema config etc

## Example Queries

http://localhost:8981/solr/articles/select?indent=true&spellcheck.q=markup_texts:(Perfrm%20HVC)&q=Perfrm%20HVC&fq=type:FactoryArticle&fq=car_uuids_sms:(8222cb90\-a822\-012a\-9d60\-f67652ef7803)&rows=0&wt=ruby

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

