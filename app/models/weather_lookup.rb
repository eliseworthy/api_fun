class WeatherLookup 
  
  attr_accessor :date, :temperature, :icon, :zip

  def initialize(zip = 20001)
    self.zip = zip 
    self.zip = 20001 if zip.blank? #refactor later
    weather_hash = fetch_weather(zip)
    assign_values(weather_hash)
    verify_attributes
  end

  def invalid?
    self.temperature == "Temp unavailable"
  end

  private

  def fetch_weather(zip) 
    HTTParty.get("http://api.wunderground.com/api/2d9fbb5d444a2858/hourly/q/#{zip}.xml") 
  end

  def assign_values(weather_hash)
    begin
      hourly_forecast_response = weather_hash.parsed_response['response']['hourly_forecast']['forecast'].first
      self.date        = hourly_forecast_response['FCTTIME']['pretty']
      self.temperature = hourly_forecast_response['temp']['english']
      self.icon        = hourly_forecast_response['icon_url']
    rescue  NoMethodError
    end
  end


  def verify_attributes
    self.date = if self.date.blank?
      Time.now
    else 
      Time.parse(self.date)  
    end

    self.temperature = "Temp unavailable"          if self.temperature.blank? 
    self.icon        = "http://cool.com/image.jpg" if self.icon.blank?
  end
end

