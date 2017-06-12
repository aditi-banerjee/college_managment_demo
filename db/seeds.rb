# unless AdminUser.any?
#   User.create(
#     email:      'admin@softices.com', 
#     password:   'password',
#   ).save(validate: false)
#   puts "Admin Done"
# AdminUser.create!(email: 'admin@college.com', password: 'password', password_confirmation: 'password')
# end
unless User.any?
  User.create(
    email:      'admin@softices.com', 
    password:   'password',
  ).save(validate: false)
  puts "Admin Done"
end