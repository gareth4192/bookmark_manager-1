def sign_in(email: 'testemail@example.com', password: 'password_duh')
  User.create(email: email, password: password, password_confirmation: password)
  visit 'sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Sign in'
end
