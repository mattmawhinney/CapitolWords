require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'json'
require './helper_methods.rb'
require './api_key.rb'


include HelperMethods


	URI_FIRST = "http://capitolwords.org/api/1/phrases/legislator.json?phrase="
	URI_THIRD = "&mincount=5&page=0&per_page=50&sort=count"
	URI_FIFTH = "&apikey=#{SUNLIGHT_KEY}"



#As a curious citizen 
#I want to be able to input a phrase 
#and find out which legislators use it most often over a given time period

class PhraseMatcher 

	def initialize(phrase,time_frame) 
		
		@uri_second = URI::encode(phrase) 
		@uri_fourth = time_frame.to_i.to_ymd
	end 


	def get_phrase(phrase)

		

# 		puts
# puts <<-PHRASE
# Please enter a common word or phrase you associate with American politics and politicians.
# For example, you might try 'CONSTITUTION', 'OBAMACARE' or 'FISCAL RESPONSIBILITY'. 

# Your entry does not need to be quoted or written in all caps.
# PHRASE
# 		prompt
# 		@phrase = gets.chomp.downcase

# 		puts
# 		puts "Your phrase is: '#{@phrase.upcase}'"
# 		puts "Is this the phrase you'd like to search?"
# 		puts "'Yes' or 'No'?"
# 		prompt 
# 		input = gets.chomp.downcase

# 		if input != "yes"
# 			get_phrase
# 		else
# 			@uri_seccond = @phrase.downcase.gsub(/\s/, '%20')
# 		end
	end 
 





		  

# 		puts
# puts <<-TIMEFRAME
# Would you like to search the Congressional Record for the use of the phrase '#{@phrase.upcase}'
# over the last '1', '5', or '10' years? Please enter '1', '5', or '10'.
# TIMEFRAME

# 		prompt
# 		self = gets.chomp.to_i


	def full_uri

		URI_FIRST + @uri_second + URI_THIRD + @uri_fourth + URI_FIFTH


	end
	



	def response_and_parse

		full_uri = URI_FIRST + @uri_second + URI_THIRD + @uri_fourth + URI_FIFTH
		response = HTTParty.get(full_uri)
		#p response.headers
		body = JSON.parse response.body
		#an array of hashes with 2 key value pairs "count" =>   , "legislator" =>
		responses = body["results"]
		# responses.map {|response| " #{response['legislator'].id_to_politician}, #{response['count'].to_i} \t\t#{response['legislator'].bioguide_uri}"}
    # counter = 1

		# responses.each do |response|
		# 		"#{counter}) #{response['legislator'].id_to_politician}, #{response['count'].to_i} \t\t#{response['legislator'].bioguide_uri}"
		# 		counter += 1 
		# 	end
	end

end 






# my_pm = PhraseMatcher.new("Obamacare", 5)
# my_pm.response_and_parse



