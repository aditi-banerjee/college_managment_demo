class StudentMailer < ApplicationMailer
   def confirmation_send(apply_admission, user)
    puts "------------------"
    @apply_admission = apply_admission
    @user = user
    mail(to: "#{@user.email}", subject: "Admission Confirmation mail")
  end

end
