# require './test_capitol_words.rb'
# include TestPhraseMatcher

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

	def to_ymd

			current_time = Time.now.to_i
   		time_frame = self * 365 * 24 * 60 * 60 
			past_time = Time.at(current_time - time_frame)
			
			past_date = past_time.strftime("%Y-%m-%d")
			current_date = Time.now.strftime("%Y-%m-%d")

		  "&start_date=#{past_date}&end_date=#{current_date}"


	end


	# def prompt
	# 	print "> "
	# end 

	# def clear 
	# 	puts "\e[H\e[2J\n" 
	# end 


end 