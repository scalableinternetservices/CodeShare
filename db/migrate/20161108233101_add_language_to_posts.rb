class AddLanguageToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :language, :string
  end
end
