class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.text :youtube_embed

      t.timestamps
    end
  end
end
