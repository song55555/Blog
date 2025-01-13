class CreateJoinTablePostTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :tags do |t|
    end
  end
end
