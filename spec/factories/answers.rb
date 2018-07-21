FactoryBot.define do
  factory :answer do
    body "MyAnswer"
    user
    question
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    user
    question
  end
end
