module PagesControllerHelper
  def create_user
    User.create(
      first_name: 'Jason',
      last_name: 'Ng',
      email: 'jason.ng@randomemail.com',
      password: 'abc123'
    )
  end
end