FactoryGirl.define do
  factory :ecm_references_reference, :class => Ecm::References::Reference do
    sequence(:name) { |i| "Reference ##{i}" }
    association :category, :factory => :ecm_references_category
  end
end

