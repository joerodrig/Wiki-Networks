# Wikipedia contains highly interconnected networks of information. Using a Breadth-First traversal,
# This script will find the minimum number of hops required to go from some starting wiki 
# some ending wiki.
#
# Authors: Joe Rodriguez, Joe Delia

require 'mechanize'
require 'json'

# A WikiPage instance is instantiated from an input of characters. These characters, or
# some slight variation of the input should direct our user to a valid wiki
class WikiPage
  def initialize(characters)
    page = getPage(characters)

    # Retrieve the page title and referenced URLS
    # Note: This loop is a workaround to the pageID being unknown initially
    page.each do |pageID,rest|
      @name        = page[pageID]['title']
      @connections = page[pageID]['links'] || []
    end

    @seen = false
  end



  # description - Retrieve the page data for a given wiki
  # TODO: Need error checking(page missing, checking for variations of title)
  # Also note that pllimit is a hard limit on how many URLs are taken from
  # any particular page. The limit for bots is 500 and can be set as 'max'
  def getPage(param)
    url = 'http://en.wikipedia.org/w/api.php?' \
           'format=json&'\
           'action=query&'\
           'titles='+param+'&'\
           'prop=links&'\
           'pllimit=25&'\
           'redirects'\

    mechPage  = Mechanize.new
    pageData  = mechPage.get(url)
    jsonPage  = JSON.parse(pageData.body)
    return jsonPage["query"]["pages"] 
  end

  # description - Retrieves references to the wikis located within a WikiPage. 
  # If no connections exist, returns an empty array
  # returns [array] Array of connected wiki pages(by String name)
  def connections
    return @connections
  end

  # description - Determine whether this page has been seen before
  # returns [bool]
  def seen
    return @seen
  end 

  # description - Retieve the name of a wiki
  # returns [String]
  def name
    return @name
  end

  # description - Mark a page as seen/unseen
  # parameters  - [bool] isSeen
  def setSeen(isSeen)
    @seen = isSeen
  end
end

class Runner
  def initialize
  	@startingPoint = ARGV[0]
    
    # Copy the endingPoint argument and format it to remove
    # any spaces and special characters. This helps us better compare
    # the results returned in the BFS to see if an exact match is made
    ep  = ARGV[1].dup
    ep.gsub!(/[!@&_ "]/,'')
  	@endingPoint   = ep

    puts "Checking path from #{@startingPoint} --> #{@endingPoint}"
  end

  #description - Run a BFS search from a given starting point until the end point is reached
  #returns [void]
  def run

    #Create new queue
    q = Queue.new

    #sPoint will contain the wiki data instance given as a starting point
    sPoint = WikiPage.new(@startingPoint)

    #enqueue the starting point and mark as seen
    q.push(sPoint)
    sPoint.setSeen(true)
    
    #Run while loop while q isn't empty
    while !q.empty? do
      
      #Extract next wiki from queue
      currentWiki = q.pop

      #For each wiki located within the current wiki
      currentWiki.connections.each do |connectedWiki| 
        #Get page data of the connected Wiki
        nextWiki = WikiPage.new(connectedWiki["title"])
        
        #add a link from current wiki to connectedWiki
        #TODO: Decide on data structure to manage this
        
        #Extract a copy of the name of the connected wiki and normalize it
        nextWikiNameNormalized = nextWiki.name.dup
        nextWikiNameNormalized.gsub!(/[!@&_ "]/,'')
        
        #Compare the normalized wiki name vs. our end point
        if @endingPoint.casecmp(nextWikiNameNormalized) == 0
          puts "Found #{@endingPoint}!"
          exit(0)
        end

        puts "#{currentWiki.name} -> #{nextWikiNameNormalized} : #{@endingPoint}"

        #If connectedWiki hasn't been seen yet
        if nextWiki.seen == false

          #Enqueue connected wiki and mark as seen
          q.push(nextWiki)
          nextWiki.setSeen(true)
          puts "Queue at: #{q.length}"
        end
      end
    end
  end
end

r = Runner.new
r.run