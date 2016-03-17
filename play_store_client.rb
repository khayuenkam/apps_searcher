require 'rest-client'
require 'nokogiri'

class PlayStoreClient
  def self.look_by_id(id)
    begin
      page = Nokogiri::HTML(RestClient.get("https://play.google.com/store/apps/details?id=#{id}"))

      name = page.at_css('.document-title[itemprop=name]').text.strip
      author = page.at_css('[itemprop=author] [itemprop=name]').text
      version = page.at_css('[itemprop=softwareVersion]').text.strip
      description = page.at_css('[itemprop=description]').text.strip
      currentVersionReleaseDate = page.at_css('[itemprop=datePublished]').text

      {
        appId: id,
        name: name,
        publisher: author,
        version: version,
        description: description,
        currentVersionReleaseDate: currentVersionReleaseDate
      }
    rescue => e
      return nil
    end
  end
end
