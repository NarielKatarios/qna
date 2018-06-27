require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question).with_foreign_key('question_id')}

  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
 end
