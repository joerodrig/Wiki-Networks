# Wikipedia contains highly interconnected networks of information. Using a Breadth-First traversal,
# This script will find the minimum number of hops required to go from some starting wiki s to 
# some ending wiki e.
#
#Authors: Joe Rodriguez, Joe Delia

require 'mechanize'


class Parse
	def initialize()
		@parser = Mechanize.new
	end

        def get(url)
          return @parser.get(url)
        end

end

class Runner
	def initialize()
	end

	def run()

		run()
	end

end





parser = Parse.new()
page = parser.get('http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Information-theoretic_security&prop=revisions&rvprop=content')

#Display the contents of the page
#puts page.body

#Display any anchor link that contains the keywork /wiki/
#page.links_with(href: /wiki/).each do |link|
#	puts link.href
