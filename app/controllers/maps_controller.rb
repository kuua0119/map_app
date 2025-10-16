class MapsController < ApplicationController
  def index
    if params[:city].present?
    results = Geocoder.search(params[:city])
    if results.present?
      @latitude = results.first.coordinates[0]
      @longitude = results.first.coordinates[1]
    else
      flash.now[:alert] = "都市が見つかりませんでした！"
    end
  end
end
end
