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
  	@startingPoint = getKeywordInput('Enter a starting point:')
  	@endingPoint   = getKeywordInput('Enter an ending point:')
    puts "Checking path from #{@startingPoint} --> #{@endingPoint}"
  end

  def getKeywordInput(msg)
  	puts msg
  	wordIn = gets.chomp
    return wordIn
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
        puts "#{currentWiki.name} -> #{nextWiki.name}"
        #add a link from current wiki to connectedWiki
        #TODO: Decide on data structure to manage this
      
        if nextWiki.name == @endingPoint
          puts "Found #{@endingPoint}!"
          exit(0)
        end

        #If connectedWiki hasn't been seen yet
        if nextWiki.seen == false

          #Enqueue connected wiki and mark as seen
          q.push(nextWiki)
          nextWiki.setSeen(true)
          puts nextWiki.connections
          puts "Queue at: #{q.length}"
        end
      end
    end
  end
end


r = Runner.new
r.run