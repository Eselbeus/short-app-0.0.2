class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url

  def short_code
    # self.id = 62**1 + 62**2 + 62**3 .....
    code = ''
    if self.id
        # if self.id > 62
        #   divisor = (self.id) / 62
        #   while divisor > 63 #63
        #     # if divisor <= 62 && divisor > 0
        #       code += CHARACTERS[divisor - 1] #62
        #     # end
        #     divisor /= 62
        #   end
        #   code += CHARACTERS[(divisor - 1) % 62]
        # end
        # # divisor -= 1
        # # code += CHARACTERS[divisor]
        # # while divisor > 62
        # #   code += CHARACTERS[divisor]
        # #   divisor -= 1
        # #   divisor /= 62
        # # end
        #
        # code += CHARACTERS[(self.id - 1) % 62]
        #
        # return code
        num = self.id
        i = 1
        prev = 0
        while (62 ** i) + prev < num
          prev += 62 ** i
          i += 1
        end
        j = 1
        while j <= i
          code += CHARACTERS[(num - 1) % 62]
          num -= (num - 1) % 62
          num /= 62
          j += 1
        end
        return code.reverse
    else
      nil
    end
  end


  def update_title!
  end

  private

  def validate_full_url
    full = self.full_url
    errors.add(:full_url, "is not a valid url") unless !full.nil? && !!full.match(/^(https?:\/\/www\.|https?:\/\/|www\.)\w+\.[\w\/]+$/)
  end
end
