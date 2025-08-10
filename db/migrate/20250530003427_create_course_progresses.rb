class CreateCourseProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :course_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :current_lesson, foreign_key: { to_table: :lessons }
      t.datetime :last_accessed_at
      t.boolean :completed

      t.timestamps
    end
  end
end
