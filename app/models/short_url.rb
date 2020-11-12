class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url

  def short_code
    code = ''
    if self.id
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
