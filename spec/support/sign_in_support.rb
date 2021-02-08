module SignInSupport

  def sign_in(user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    find('input[name="commit"]').click
  end

end