class IntercomClient

  # Setting up Intercom with # With Personal Access token: you can get it
  # https://app.intercom.io/developers/blah-blah-square/access-token
  def initialize(your_app_token)
    @@intercom = Intercom::Client.new(token: your_app_token)
  end
end