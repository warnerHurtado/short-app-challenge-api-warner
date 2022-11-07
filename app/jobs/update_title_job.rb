class UpdateTitleJob < ApplicationJob
  queue_as :default

  #Jop for update the title
  def perform(short_url_id)
    url = ShortUrl.find_by(id: short_url_id)
    url.update_title!
  end
end
