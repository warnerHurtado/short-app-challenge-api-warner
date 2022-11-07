class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    number = self.id
    url_code = ""

    while number > 0
      result = number % 62
      url_code.prepend( CHARACTERS[result] )
      number = ( number / 62 ).floor
    end

    self.url_code = url_code
    self.save
    url_code
  end

  def update_title!
    new_title = full_url.split("//")[1].split('/')[0]
    self.title = new_title
    self.save
  end

  private

  def is_valid_url?
    uri = URI.parse(full_url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_full_url
    is_correct_url = is_valid_url?
    
    if !is_correct_url
      errors.add( :full_url, "is not a valid url" )
    end
  end

end
