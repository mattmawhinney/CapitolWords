require './test_capitol_words.rb'
include TestPhraseMatcher

module HelperMethods

	def id_to_politician
		
		start_uri = "http://bioguide.congress.gov/scripts/biodisplay.pl?index="
		bioguide_uri = start_uri + self 
		response = HTTParty.get(bioguide_uri)
		sleep(0.5)
		
		dom = Nokogiri::HTML(response.body)
		raw_name = dom.xpath("//a[@name='Top']").first.content
		middle_step = raw_name.split(",") 
		

		first_and_last = "#{middle_step[1].strip.split(" ")[0].capitalize} #{middle_step[0].capitalize}"
	end 

	def bioguide_uri 
		start_uri = "http://bioguide.congress.gov/scripts/biodisplay.pl?index="
		bioguide_uri = start_uri + self 

	end 


	def prompt
		print "> "
	end 

	def clear 
		puts "\e[H\e[2J\n" 
	end 


	


		# want a method that 


end 