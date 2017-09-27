class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text
      t.integer :views_count, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
