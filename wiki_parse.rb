// Wikipedia contains highly interconnected networks of information. Using a Breadth-First traversal,
// This script will find the minimum number of hops required to go from some starting wiki s to 
// some ending wiki e
//
// Authors: Joe Rodriguez, Joe Delia

require 'mechanize'


class Parse
	def initialize()
		@parser = Mechanize.new
	end

end

class Runner
	def initialize()
	end

	def run()

		run()
	end

end





page = mechanize.get('http://en.wikipedia.org/wiki/Information-theoretic_security')


page.links_with(href: /wiki/).each do |link|
	puts link.href
end
