require 'spec_helper'

describe 'ecm/references/references/show.html.erb' do
  before do
    assign(:reference,
      FactoryGirl.create(:ecm_references_reference, :name => 'Foo')
    )
    render
  end # before

  it "displays the reference" do
    rendered.should include('Foo')
  end # it
end # describe 'ecm/references/references/show.html.erb'

