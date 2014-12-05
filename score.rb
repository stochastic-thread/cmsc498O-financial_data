#!/usr/bin/env ruby

require 'curb'
require 'json'

i = 1
total = 10373
while (i < total) 
	sc = Curl.get('localhost:9200/news/all2/' +i.to_s)
	s = sc.body_str
	sleep(0.0001)
	pc = Curl.get('localhost:9200/news/pc/'   +i.to_s )

	p = pc.body_str

	id = i

	s = JSON.parse(s)
	sentiment = s["_source"]["data"]["sentiment"]
	score 		= s["_source"]["data"]["score"]

	p = JSON.parse(p)
	change 		= p["_source"]["data"]["percent_change"]

	json_new = {}
	json_new[:data] = {}
	d = json_new[:data]

	d[:sentiment] = sentiment
	d[:score] = score
	d[:change] = change
	
	g = JSON.pretty_generate(json_new)
	posted = Curl.post('localhost:9200/news/combined/'+i.to_s, g)
	puts posted.body_str
	i += 1
end