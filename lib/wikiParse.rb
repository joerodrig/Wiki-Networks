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

    # Retrieve the page title and the wikis which reference it
    @name = characters
    @connections = page["backlinks"]
    @seen = false
  end

  # description - Retrieve the page data for a given wiki
  # Note that 'bllimit' is a hard limit on how many URLs are taken from
  # any particular page. The limit for bots is 500 (set as 'max')
  def getPage(param)
    url = 'http://en.wikipedia.org/w/api.php?' \
           'format=json&'\
           'list=backlinks&'\
           'action=query&'\
           'bltitle='+param+'&'\
           'redirects&'\
           'blfilterredir=all&'\
           'bllimit=20'

    mechPage  = Mechanize.new
    pageData  = mechPage.get(url)
    jsonPage  = JSON.parse(pageData.body)
    return jsonPage["query"]
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
  	@stepsOut = ARGV[0].to_i || 0
    
    # Copy the endingPoint argument and format it to remove
    # any spaces and special characters. This helps us better compare
    # the results returned in the BFS to see if an exact match is made
    # If no point was entered, exit the program
    if ARGV[1] != nil
      ep  = ARGV[1].dup || nil
      ep.gsub!(/[!@&_ .\:\-\/"]/,'_')
      @startingPoint   = ep
    else 
      exit(0) 	
    end

    # Specify the maximum number of points
    # if no maximum number is specified, the 
    # parse will continue until
    if ARGV[2] != nil
      maxPointsIn = ARGV[2].dup.to_i
      @pointsLeftToSearch  = maxPointsIn
    end

    
  end

  #description - Run a BFS search from a given starting point until
  # the specified limit is reached
  #returns [void]
  def run

    # Create new queue
    q = Queue.new

    # Tracker Queue
    tracker = Queue.new

    #sPoint will contain the wiki data instance given as a starting point
    sPoint = WikiPage.new(@startingPoint)

    #Enqueue the starting point and mark as seen
    q.push(sPoint)

    #Enqueue an item in the tracker
    tracker.push(1)

    sPoint.setSeen(true)
    
    #Run while loop while q isn't empty
    while !q.empty? && @stepOut != 0 && @pointsLeftToSearch != 0 do
      #Extract next wiki from queue
      currentWiki = q.pop
      tracker.pop
      if @pointsLeftToSearch != nil then @pointsLeftToSearch -= 1 end

      #For each wiki that refers to the current wiki (backlink)
      currentWiki.connections.each do |referingWiki| 

        next if referingWiki["title"].include? "User:" || "Talk:" || "User talk:" || "Wikipedia:"

        #Get page data of the refering Wiki
        nextWiki = WikiPage.new(referingWiki["title"])
        
        #Extract a copy of the name of the refering wiki and normalize it
        nextWikiNameNormalized = nextWiki.name.dup
        nextWikiNameNormalized.gsub!(/[!@&_ .\:\-\/"]/,'_')
        
        #OUTPUT Connection
        wikiOutput = "\"#{currentWiki.name}\" -- \"#{nextWikiNameNormalized}\""
        
        #edge is blue if starting point -> next point
        if @stepsOut == ARGV[0].to_i
          wikiOutput += "[color=blue];"
        #edge is red from second to last point -> last point
        elsif @stepsOut == 1
           wikiOutput += "[color=red];"
        #edge is black otherwise
        else
           wikiOutput += "[color=black];"
        end
        puts wikiOutput

        if !nextWiki.seen

          #Enqueue connected wiki and mark as seen
          q.push(nextWiki)
          nextWiki.setSeen(true)
        end
      end

      # Increment tracker
      if tracker.length() == 0 
        @stepsOut -= 1
        while tracker.length() < q.length()
          tracker.push(1)
        end
      end
    end
  end
end

r = Runner.new
r.run