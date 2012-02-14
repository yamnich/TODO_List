Factory.define :user do |user|
    user.name 'John Doe'
    user.email"email@test.com"
    user.password '111111'
    user.password_confirmation{|u| u.password}
  end