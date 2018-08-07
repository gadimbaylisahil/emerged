module LoginSupport
  def login_user(user:, password:)
    valid_credentials =  { "email": user.email, password: password}
    post '/v1/sessions', params: valid_credentials

    valid_jwt_token = JSON.parse(response.body)["token"]
    { "Authorization": "Bearer #{valid_jwt_token}", "Content-Type": "application/vnd.api+json" }
  end
end