class MapsController < ApplicationController
  def index
    session[:cities] ||= []  # 空なら初期化

    if params[:city].present?
      results = Geocoder.search(params[:city])
      if results.present?
        @latitude = results.first.coordinates[0]
        @longitude = results.first.coordinates[1]

        # 最近の検索を記録（重複除去、最大5件まで）
        city = params[:city].strip
        session[:cities].delete(city)
        session[:cities].unshift(city)
        session[:cities] = session[:cities].take(5)
      else
        flash.now[:alert] = "都市が見つかりませんでした！"
      end
    end

    @cities = session[:cities]
  end
end