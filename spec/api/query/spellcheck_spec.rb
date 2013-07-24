require 'spec_helper'

describe 'standard query', :type => :query do

  it 'turns faceting on if facet is requested' do
    search do
      spellcheck
    end

    connection.should have_last_search_with(:spellcheck => true)
  end

  # TODO: Check other options

  private

  def search(*classes, &block)
    classes[0] ||= Article
    session.search(*classes, &block)
  end
end
