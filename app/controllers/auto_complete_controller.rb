class AutoCompleteController < ApplicationController
before_action :authenticate_user!
  def students
    puts "=-=-=--=-=-=--"
    completion = Student.where("first_name LIKE ?", "#{params[:search]}%")
    puts "-=-=-=-=-==-==-"
    puts completion.to_json
    puts "-=-=-=-=-=-==-="
    render json: completion, status: :ok
  end
end
