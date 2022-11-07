class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    urls = ShortUrl.limit( 100 ).order('click_count desc').map { |short_code| short_code.short_code }
    render status: 200, json: { urls: urls }
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
        render status: 400, json: url.errors
      end
    end
  end

  def show
    url_code = ShortUrl.find_by( url_code: params[:id] )
    
    if url_code
      clicks_count = url_code.click_count + 1
      url_code.update_attributes( :click_count => clicks_count )

      redirect_to url_code.full_url, allow_other_host: true
    else
      render status: 404, json: { errors: "Do not exist an URL with that code."}
    end
  end

end
