namespace :scrapper do
  desc "Fetch Craiglist lands from 	3taps"
  task scrape: :environment do

  	require 'open-uri'
	require 'json'

	#Set API Token

	auth_token = 'fbfc5618560c5da309c456ea84cf3571'
	polling_url = 'http://polling.3taps.com/poll'

	#Specify reques parameters
	params ={
		auth_token: auth_token,
		anchor: 2162948680,
		source: "CRAIG",
		category_group: "RRRR",
		category: "RHFR",
		'location.city' => 'USA-NYM-BRL',
		retvals: "location,external_url,heading,body,timestamp,price,images,annotations"
	}

	# Prepara API Request

	uri = URI.parse(polling_url)
	uri.query = URI.encode_www_form(params)

	#Submit Request

	result = JSON.parse(open(uri).read)

	#Display Results

	#puts result["postings"].first["heading"]

	#Store results in db
	result["postings"].each do |posting|

		#Create New Post

		@land = Land.new
		@land.heading = posting["heading"]
		@land.body = posting["body"]
		@land.price = posting["price"]
		@land.neighborhood = posting["location"]["locality"]
		@land.external_url = posting["external_url"]
		@land.timestamp = posting["timestamp"]

		#save Post

		@land.save
	end

  end

  desc "TODO"
  task destroy_all_lands: :environment do
  end

end
