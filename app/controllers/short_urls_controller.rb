class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    url = ShortUrl.find_by( full_url: params[:full_url] )

    if url
      render status: 200, json: { short_code: url.short_code } 
    else
      url = ShortUrl.create( full_url: params[:full_url] )

      if url.save
        UpdateTitleJob.perform_now( url.id )
        render status: 201, json: { short_code: url.short_code }
      else
        render status: 400, json: { errors: url.errors}
      end
    end
  end

  def show
  end

end
