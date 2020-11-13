class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @short_urls = ShortUrl.all
    render json: @short_urls
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.save
      render json: @short_url.as_json(methods: [:short_code])
    else
      render json: @short_url.errors
    end
  end

  def show
    @short_url = ShortUrl.find_by_short_code(params[:id])
    if @short_url
      @short_url.click_count += 1
      @short_url.save
      redirect_to @short_url.full_url
    else
      render json: @short_url.errors
    end
  end

  private

  def short_url_params
    params.permit(:full_url, :title, :click_count)
  end

end
