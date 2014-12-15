require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do

  describe "GET index" do

    it "sends a successful HTTP GET request" do
      stub_request(:get, "https://api.github.com/zen").
         to_return(:status => 200)
    end
  end

end
