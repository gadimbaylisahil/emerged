module LoginSupport
  def login_user(user:, password:)
    valid_credentials =  { "email": user.email, password: password}
    post '/sessions', params: valid_credentials

    valid_jwt_token = JSON.parse(response.body)["token"]
    headers = { "Authorization": "Bearer #{valid_jwt_token}" }
  end
end