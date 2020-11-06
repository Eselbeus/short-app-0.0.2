class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url

  def short_code

  end

  def update_title!
  end

  private

  def validate_full_url
    full = self.full_url
    errors.add(:full_url, "is not a valid url") unless !full.nil? && !!full.match(/^(https?:\/\/www\.|https?:\/\/|www\.)\w+\.[\w\/]+$/)
  end
end
