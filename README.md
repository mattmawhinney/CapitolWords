Welcome to "Matt's Congressional Words Matcher" powered by the the
Sunlight Foundation's Capitol Words API (http://tryit.sunlightfoundation.com/capitolwords).

This is a simple program that allows users to input a word or phrase and see how frequently it has been used by members of Congress speaking on the record over the last 1,5, or 10 years.

You'll need to go to http://sunlightfoundation.com/api/ to get your own API key. Then find 
the @uri_fifth = "&apikey=#{@api_key}" instance varible in the initialze method in capitol_words.rb. You can replace #{@api_key} with your own key like so: 
				@uri_fifth = "&apikey=2z02906147fg19ads94a590a45eb385m"
Then, you're good to go. 