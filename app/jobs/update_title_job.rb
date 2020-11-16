require 'open-uri'

class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    title_line = ''
    url = URI.open(ShortUrl.find(short_url_id).full_url) do |f|
      f.each_line do |line|
        if line.include?("<title>")
          title_line = line.strip()
          title_line = title_line[7..-9]
        end
      end
    end
    ShortUrl.find(short_url_id).update({title: title_line})
    return title_line
  end
end
