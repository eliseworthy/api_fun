class PagesController < ApplicationController
  def home
    @washington_lookup = WeatherLookup.new(20001)
    @weather_lookups = [ WeatherLookup.new(params[:zip]) ]
    @weather_lookups.delete_if { |wl| wl.invalid? }
  end
end
