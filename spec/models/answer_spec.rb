require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question).with_foreign_key('question_id')}
  it { should belong_to(:user).with_foreign_key('user_id')}
  it { should have_many(:attachments)}
  it { should have_many(:votes)}

  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }

  it { should accept_nested_attributes_for :attachments }

end
