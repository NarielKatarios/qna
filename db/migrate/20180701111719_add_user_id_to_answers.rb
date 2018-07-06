class AddUserIdToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :user_id, :integer
    remove_column :answers, :title, :string
  end
end
