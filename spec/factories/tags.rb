FactoryBot.define do
  factory :tag do
    association :user
    association :album
  end
end
