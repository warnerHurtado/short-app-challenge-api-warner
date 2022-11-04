class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    url = ShortUrl.find_by( full_url: params[:full_url] )
    if url.save
      render status: 200, json: { short_code: url } 
    else
      url = ShortUrl.create( full_url: params[:full_url] )
      render status: 201, json: { short_code: url }
    end
  end

  def show
  end

end
