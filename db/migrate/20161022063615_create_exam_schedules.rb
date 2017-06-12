class CreateExamSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_schedules do |t|
      t.date     :exam_date
      t.time     :exam_start_time
      t.time     :exam_end_time
      t.integer  :trade_id
      t.integer  :semester
    end
  end
end
