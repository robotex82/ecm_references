require 'spec_helper'

module Ecm::References
  describe Category do
    describe 'associations' do
      it { should have_many :references }
    end # describe 'associations'

    describe 'nested set' do
      describe 'with a root node' do
        subject { FactoryGirl.build(:ecm_references_category) }

        it 'should be a root node' do
          subject.root?.should eq(true)
        end # it
      end # describe 'with a root node'
    end # describe 'nested set'

    describe 'friendly id' do
      subject { FactoryGirl.create(:ecm_references_category, :name => 'A category with a friendly id!') }

      it 'should be generate from its name' do
        subject.to_param.should eq('a-category-with-a-friendly-id')
      end # it
    end # describe 'friendly id'

    describe 'markup' do
      subject do
        FactoryGirl.build(
          :ecm_references_category,
          :description => 'h1. This is the description'
        ) 
      end # subject

      it 'should use textile as default markup language' do
        subject.description.to_html.should eq('<h1>This is the description</h1>')
      end # it
    end # describe 'markup'

    describe 'public methods' do
      describe '#to_s' do
        subject { FactoryGirl.create(:ecm_references_category, :name => 'Example category')  }

        it 'should return a human readable label' do
          subject.to_s.should eq('Example category')
        end # it
      end # describe '#to_s'
    end # describe 'public methods'

    describe 'validations' do
      it { should validate_presence_of(:markup_language) }
      it { should ensure_inclusion_of(:markup_language).in_array(Ecm::References::Configuration.markup_languages.map(&:to_s)) }
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).scoped_to(:parent_id) }
    end # describe 'validations'
  end # describe Category
end # module Ecm::References

