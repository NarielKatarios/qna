FactoryBot.define do
  factory :attachment do
    file { File.new(Rails.root.join('spec', 'rails_helper.rb')) }
    #file "MyString"
  end
end
