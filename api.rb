require 'sinatra'
require './itunes_client'
require './play_store_client'

get '/search/:app' do 
  content_type :json

  case params[:app]
    when 'android'
      halt 400 if params[:id].nil?
      data = PlayStoreClient.look_by_id(params['id'])
      unless data.nil?
        data.to_json
      else
        halt 204
      end
    when 'itunes'
      halt 400 if params[:id].nil?
      data = ITunesClient.look_by_id(params['id'])
      unless data.nil?
        data.to_json
      else
        halt 204
      end
    else
      halt 404
    end
end
