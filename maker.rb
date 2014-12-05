#!/usr/bin/env ruby

require 'curb'
require 'json'

list = [ 
	"eurodollar",
	"eza",
	"poundyen",
	"gold",
	"nge",
	"silver",
	"spy",
	"tmkr",
	"dollaryen",
	"dji"
]

list.each {|item|
	h = File.open("#{item}_12.csv","w+")
	h.puts "score,percent_change"

	d = File.open("#{item}_24.csv","w+")
	d.puts "score,percent_change"

	diff = File.open("#{item}_diff.csv","w+")
	diff.puts "score,percent_change"

	i = 0
	total = 10373

	while (i < total)
		http = Curl.get('localhost:9200/news/combined/'+i.to_s)
		body = http.body_str
		parsed = JSON.parse(body)
		src = parsed["_source"] if !(parsed.nil?)
		#puts "1" + parsed
		data = src["data"] 		if !(src.nil?)
		#puts "2" + src
		score = data["score"] 	if !(data.nil?)
		#puts "3" + data["score"]
		change = data["change"] if !(data.nil?)
		#puts "3" + data["change"]
		itm = change[item] if !(change.nil?)
		#puts "3" + data["change"]
		halfday_change = itm["hours_12"] if !(itm.nil?)
		day_change = itm["hours_24"] if !(itm.nil?)
		
		if (day_change != nil && halfday_change != nil)
			intra_change = (day_change - halfday_change)
		end
		
		if (halfday_change != nil)
			h.puts "#{score},#{halfday_change}"
		end
		
		if (day_change != nil) 
			d.puts "#{score},#{day_change}"
		end

		if (intra_change != nil) 
			diff.puts "#{score},#{intra_change}"
		end

		i += 1
	end
}



