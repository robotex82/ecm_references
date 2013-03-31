# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecm_references_category, :class => Ecm::References::Category do
    sequence(:name) { |i| "Reference category ##{i}" }
  end
end
