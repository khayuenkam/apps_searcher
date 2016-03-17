require 'json'
require 'rest-client'

class ITunesClient
  def self.look_by_id(id)
    begin
      response = RestClient.get "https://itunes.apple.com/lookup?id=#{id}", {:accept => :json} 
      results = JSON.parse(response)["results"]

      if results.empty?
        nil
      else
        data = results.first

        {
          appId: id,
          name: data["trackName"],
          publisher: data["artistName"],
          version: data["version"],
          description: data["description"],
          currentVersionReleaseDate: data["currentVersionReleaseDate"]
        }
      end
    rescue => e
      return nil
    end
  end
end
