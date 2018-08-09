module LoginSupport
  def login_user(user:, password:)
    valid_credentials =  { "email": user.email, password: password}
    post '/v1/sessions', params: valid_credentials

    valid_jwt_token = JSON.parse(response.body)["token"]
    { "Authorization": "Bearer #{valid_jwt_token}" }.merge(json_api_headers)
  end

  def json_api_headers
    {'Accept' => JSONAPI::MEDIA_TYPE, 'CONTENT_TYPE' => JSONAPI::MEDIA_TYPE}
  end
end