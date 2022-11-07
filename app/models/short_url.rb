class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  #Generate short_code by ShortUrl.id
  def short_code
    return nil if self.id.nil?

    number = self.id
    url_code = ""

    while number > 0
      result = number % 62
      url_code.prepend(CHARACTERS[result])
      number = (number / 62).floor
    end

    self.url_code = url_code
    self.save
    url_code
  end

  #Get ShortUrl.short_code
  def public_attributes
    self.short_code
  end

  #Update title by getting the tag title
  def update_title!
    new_title =  Net::HTTP.get(URI.parse(full_url)).match(/<title.*?>(.*)<\/title>/)[1]
    self.title = new_title
    self.save
      
    rescue => e
      errors.add( :title, e)
  end

  #Find ShortUrl by short_code
  def self.find_by_short_code(short_code)
    ShortUrl.find_by(url_code: short_code)
  end

  private

  #Validate if is a URL
  def is_valid_url?
    uri = URI.parse(full_url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?

  rescue URI::InvalidURIError
    false
  end

  #Validate URL param
  def validate_full_url
    is_correct_url = is_valid_url?
    
    if !is_correct_url
      errors.add(:errors, "Full url is not a valid url")
      errors.add(:full_url, "is not a valid url" )
      !full_url && errors.add(:full_url, "can't be blank")
    end
  end

end
