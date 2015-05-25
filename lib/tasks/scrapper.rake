namespace :scrapper do
  desc "Fetch Craiglist lands from 	3taps"
  task scrape: :environment do

  	require 'open-uri'
	require 'json'

	#Set API Token

	auth_token = 'fbfc5618560c5da309c456ea84cf3571'
	polling_url = 'http://polling.3taps.com/poll'

	# Grab data  until up-to-date
	loop do 

		#Specify reques parameters
		params ={
			auth_token: auth_token,
			anchor: Anchor.first.value,
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

		#puts JSON.pretty_generate result["postings"]

		#puts result["postings"].first["heading"]

		#Store results in db
		 result["postings"].each do |posting|

		 	#Create New Post

		 	@land = Land.new
		 	@land.heading = posting["heading"]
		 	@land.body = posting["body"]
		 	@land.price = posting["price"]
		 	@land.neighborhood = Location.find_by(code: posting["location"]["locality"]).try(:name)
		 	@land.external_url = posting["external_url"]
		 	@land.timestamp = posting["timestamp"]

	 		@land.bedrooms = posting["annotations"]["bedrooms"]if posting["annotations"]["bedrooms"].present?
	 		@land.bathrooms = posting["annotations"]["bathrooms"]if posting["annotations"]["bathrooms"].present?
	 		@land.sqft = posting["annotations"]["sqft"]if posting["annotations"]["sqft"].present?
	 		@land.cats = posting["annotations"]["cats"]if posting["annotations"]["cats"].present?
	 		@land.dogs = posting["annotations"]["dogs"]if posting["annotations"]["dogs"].present?
	 		@land.w_d_in_units = posting["annotations"]["w_d_in_units"]if posting["annotations"]["w_d_in_unit"].present?
	 		@land.street_parking = posting["annotations"]["street_parking"]if posting["annotations"]["street_parking"].present?

		 	#save Post

		 	@land.save

		 	#Save Images to database
		 	posting["images"].each do |image|
		 		@image =Image.new
		 		@image.url = image["full"]
		 		@image.land_id = @land.id
		 		@image.save
		 	end
		 end

		 Anchor.first.update(value: result["anchor"])
		 puts Anchor.first.value
		 break if result ["postings"].empty?
	end
  end

  desc "Destroy all postings data"
  task destroy_all_lands: :environment do
  	Land.destroy_all
  end

  desc "Save neighborhood codes in a reference table"
  task scrape_neighborhoods: :environment do
	  	require 'open-uri'
		require 'json'

		#Set API Token

		auth_token = 'fbfc5618560c5da309c456ea84cf3571'
		location_url = 'http://reference.3taps.com/locations'

		#Specify reques parameters
		params ={
			auth_token: auth_token,
			level: "locality",
			city: "USA-NYM-BRL"
		}

		# Prepara API Request

		uri = URI.parse(location_url)
		uri.query = URI.encode_www_form(params)

		#Submit Request

		result = JSON.parse(open(uri).read)

		#puts JSON.pretty_generate result

		#Store Results in Database

		result["locations"].each do |location|
			@location = Location.new
			@location.code = location["code"]
			@location.name = location["short_name"]

			@location.save
		end
	end
end
