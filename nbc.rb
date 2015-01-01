#!/usr/bin/env ruby

require 'rest-client'
require 'json'

nbc_url = 'http://stream.nbcsports.com/data/mobile/mcms/prod/nbc-live.json'

def get_streams(url)

  r = RestClient::Resource.new(url, :timeout => 10, :open_timeout => 10).get
  data = JSON.parse(r)
  puts "Please select a stream"
  data.each_with_index do |t, i|
    puts "#{i}: #{t["title"]}"
  end
  choose_stream = gets.chomp
  if choose_stream.to_i > data.length
    puts "Please select a valid option"
    exit 1
  end

  stream_url = data[choose_stream.to_i]["iosStreamUrl"]
  final_stream_url = stream_url.gsub('manifest(format=m3u8-aapl-v3)', 'QualityLevels(1400000)/Manifest(video,format=m3u8-aapl-v3,audiotrack=audio_en_0)')
  return final_stream_url
end

url = get_streams(nbc_url)
puts url
