class AddSongIdColumnToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :song_id, :string
  end
end
