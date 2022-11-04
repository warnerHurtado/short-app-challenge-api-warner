class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    number = ShortUrl.all.length
    url_code = ""
    while number > 0
      result = number % 62
      url_code.prepend( CHARACTERS[result] )
      number = ( number / 62 ).floor
    end
    url = ShortUrl.find_by(full_url: full_url)
    url.url_code = url_code
    url.save
    url_code
  end

  def update_title!
  end

  private

  def validate_full_url
  end

end
