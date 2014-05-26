require 'httparty'
require 'nokogiri'
require 'json'
require './test_capitol_words.rb'
require './helper_methods.rb'
require './api_key.rb'

include TestPhraseMatcher
include HelperMethods
include APIKey 


#As a curious citizen 
#I want to be able to input a phrase 
#and find out which legislators use it most often over a given time period

class PhraseMatcher 

	def initialize 
		@uri_first = "http://capitolwords.org/api/1/phrases/legislator.json?phrase="
		@uri_third = "&mincount=5&page=0&per_page=50&sort=count"
		@uri_fifth = "&apikey=#{api_key}"
		program_loop
		
	end 


	private 


	def program_loop

		while true 
			clear
puts <<-LOOP
Welcome to "Matt's Congressional Words Matcher" powered by the the
Sunlight Foundation's Capitol Words API (http://tryit.sunlightfoundation.com/capitolwords).
Hit 'Control + C' at anytime to stop the program. 
LOOP

			get_phrase
			get_time_frame
			response_and_parse
		end 

	end 

	def get_phrase
		puts
puts <<-PHRASE
Please enter a common word or phrase you associate with American politics and politicians.
For example, you might try 'CONSTITUTION', 'OBAMACARE' or 'FISCAL RESPONSIBILITY'. 

Your entry does not need to be quoted or written in all caps.
PHRASE
		prompt
		@phrase = gets.chomp.downcase

		puts
		puts "Your phrase is: '#{@phrase.upcase}'"
		puts "Is this the phrase you'd like to search?"
		puts "'Yes' or 'No'?"
		prompt 
		input = gets.chomp.downcase

		if input != "yes"
			get_phrase
		else
			@uri_seccond = @phrase.downcase.gsub(/\s/, '%20')
		end
	end 
 


	def get_time_frame

		puts
puts <<-TIMEFRAME
Would you like to search the Congressional Record for the use of the phrase '#{@phrase.upcase}'
over the last '1', '5', or '10' years? Please enter '1', '5', or '10'.
TIMEFRAME

		prompt
		@time_frame = gets.chomp.to_i


		if (@time_frame == 1 || @time_frame == 5 || @time_frame == 10) 
			current_time = Time.now.to_i
			time_frame = @time_frame * 365 * 24 * 60 * 60 
			past_time = Time.at(current_time - time_frame)
			
			past_date = past_time.strftime("%Y-%m-%d")
			current_date = Time.now.strftime("%Y-%m-%d")

			@uri_fourth = "&start_date=#{past_date}&end_date=#{current_date}"
		else 
			get_time_frame
		end 

		

	end


	def response_and_parse

		full_uri = @uri_first + @uri_seccond + @uri_third + @uri_fourth +@uri_fifth
		response = HTTParty.get(full_uri)
		#p response.headers
		body = JSON.parse response.body
		#an array of hashes with 2 key value pairs "count" =>   , "legislator" =>
		responses = body["results"]

		if responses.empty? 
			puts
			puts "It looks like no member of Congress has said '#{@phrase.upcase}'"
			puts "on the floor of the House or Senate in the last #{@time_frame == 1 ? 'year' : @time_frame.to_s + ' years'}"
			puts
			puts "Let's try another phrase"
			sleep(5)
			get_phrase
		else
			puts
			puts "The phrase '#{@phrase.upcase}' has been used by the following politicians"
			puts "over the last #{@time_frame == 1 ? 'year' : @time_frame.to_s + ' years'} on the floor of the United States Congress."
			puts
			puts "Politicians are listed in descending order of number of times they've used the phrase (minimum 5 uses)"
			puts "with the number of uses and the URL of the politician's Congressional Bioguide website included."
			puts
			sleep(8)

			count = 1

			responses.each do |response|
				puts "#{count}) #{response['legislator'].id_to_politician}, #{response['count'].to_i} \t\t#{response['legislator'].bioguide_uri}"
				count += 1 
			end
			puts
			puts "The screen will clear in a moment, but you can scroll back up to see your search results"
			sleep(5)
		end 

	end 


end 

# test_get_phrase
# test_response_and_parse
# test_id_to_politician


PhraseMatcher.new



