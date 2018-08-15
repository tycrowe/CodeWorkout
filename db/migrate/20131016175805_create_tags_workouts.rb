class CreateTagsWorkouts < ActiveRecord::Migration
  def change
    create_table :tags_workouts do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :workout, index: true
    end
  end
end
