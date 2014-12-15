class WelcomeController < ApplicationController
  include HTTParty
  def index
    @doge = ['Get more, get doge.', 'Doge the real dream.', 'Good Mornings begin with doge.']
    auth = {:username => ENV['GIT_LOGIN'], :password => ENV['GIT_PASSWORD']}
    @quote = HTTParty.get("https://api.github.com/zen",
                     :basic_auth => auth)
    if @quote.message != 'Not Found'
      @quote
    else
      @quote = @doge.sample
    end
  end
end
