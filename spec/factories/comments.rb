FactoryBot.define do
  factory :comment do
    body { 'MyComment' }
    user
    question
    answer
  end
end
