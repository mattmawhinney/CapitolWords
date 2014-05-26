module TestPhraseMatcher


	def test_get_phrase 
		#have to comment out program_loop in PhraseMatcher initialize

		my_matcher = PhraseMatcher.new
		puts my_matcher.send(:get_phrase_input,'Middle Class') == 'middle%20class'
		puts my_matcher.send(:get_phrase_input,'WAR ON TERROR') == 'war%20on%20terror'

	end 


	def test_response_and_parse
    #have to comment out program_loop in PhraseMatcher initialize
		my_matcher = PhraseMatcher.new
		
		my_matcher.send(:get_phrase_input,'war on women')
		my_matcher.send(:get_time_frame_input, 10)
		#should return popoluated array 
		puts my_matcher.send(:response_and_parse).empty? == false
		sleep(2)
	  
	  my_matcher.send(:get_phrase_input,'stephen colbert')
	  my_matcher.send(:get_time_frame_input, 10)
	  #should return empty array 
		my_matcher.send(:response_and_parse).empty? == true 
		

	end 


	def test_id_to_politician
		puts 'W000238'.id_to_politician == "Daniel Webster"
		puts 'C000482'.id_to_politician == "Henry Clay"
	end

	# def test_get_time_frame
	# 	#have to comment out program_loop in PhraseMatcher initialize
	# 	my_matcher = PhraseMatcher.new
	# 	puts my_matcher.send(:get_time_frame_input, 1) == "#{@uri_fourth}"
	# 	puts my_matcher.send(:get_time_frame_input, 5) == "#{@uri_fourth}"
	# 	puts my_matcher.send(:get_time_frame_input, 10) == "#{@uri_fourth}"
	# 	puts my_matcher.send(:get_time_frame_input, 10) == "#{@uri_fourth}"

	# end 

	

	def get_phrase_input(phrase)
		@phrase = phrase.downcase 
		
		@uri_seccond = phrase.downcase.gsub(/\s/, '%20')

	end

	def get_time_frame_input(time_frame)


		@time_frame = time_frame

		current_time = Time.now.to_i
		time_frame = time_frame * 365 * 24 * 60 * 60 
		past_time = Time.at(current_time - time_frame)
		
		past_date = past_time.strftime("%Y-%m-%d")
		current_date = Time.now.strftime("%Y-%m-%d")

		@uri_fourth = "&start_date=#{past_date}&end_date=#{current_date}"

		

	end






end