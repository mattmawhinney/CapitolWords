require 'sinatra'
require 'erb'


get "/" do

	erb :search

end 


post "/" do 
	@input_phrase = params[:phrase]
	@input_time_frame = params[:time_frame]

	erb :results
	# erb :results, :locals => {:time_frame => time_frame} 


end 