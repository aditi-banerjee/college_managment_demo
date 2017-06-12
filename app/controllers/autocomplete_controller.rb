class AutocompleteController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  before_action :restrict_format
  before_action :authenticate_user!

  def completion
    puts "=-=-=--=-=-=--"
    puts Student.where("first_name LIKE ? OR last_name LIKE ?", "#{params[:search]}%")
    puts "-=-=--=-=-=-==-"
    completion = Student.where("first_name LIKE ? OR last_name LIKE ?", "#{params[:search]}%")
    puts "-=-=-=-=-==-==-"
    puts completion
    puts "-=-=-=-=-=-==-="
    render json: completion, status: :ok
  end

  private
  def restrict_format
    unless request.format == 'application/json'
      redirect_to "/", :notice => "Invalid/Unauthorized Call"
    else
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
      response.headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end
end
