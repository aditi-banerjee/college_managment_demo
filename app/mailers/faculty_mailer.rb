class FacultyMailer < ApplicationMailer
  def job_confirmation(apply_job, user)
    @apply_job = apply_job
    @user = user
    mail(to: "#{@user.email}", subject: "Admission Confirmation mail")
  end
end
