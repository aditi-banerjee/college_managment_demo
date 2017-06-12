class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if resource.access_role == 'student'
        if Student.exists?(user_id: current_user.id)
          home_path
        else
        new_student_path
        end
      elsif resource.access_role == 'faculty'
      if Faculty.exists?(user_id: current_user.id)
        home_path
      else
        new_faculty_path
      end
      else
        home_path
      end
    else
      admin_dashboard_path
    end
  end

  def com_condition(params, column, conditions, condition_type)
    unless params.blank?
      conditions[0] = conditions[0].to_s + (conditions[0].blank? ? '' : ' and ') + " #{column} #{condition_type} ? "
      conditions << if condition_type == 'like'
                      "%#{params}%"
                    else
                      params
                    end
    end
    params
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up){
        |u| u.permit(
          :email,
          :password,
          :password_confirmation,
          :provider,
          :uid
        )
      }
      devise_parameter_sanitizer.permit(:sign_in){
        |u| u.permit(
          :email,
          :password
        )
      }
    end
end
