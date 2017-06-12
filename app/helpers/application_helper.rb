module ApplicationHelper
  def select_trade_data
    Trade.all.pluck(
      :name,
      :id
    )
  end

  def select_student_data
    Student.all.pluck(
      :first_name,
      :id
    )
  end

  def select_faculty_data
    Faculty.all.pluck(
      :first_name,
      :id
    )
  end

  def select_fees_data
    Fee.all.pluck(
      :amount,
      :id
    )
  end
end
