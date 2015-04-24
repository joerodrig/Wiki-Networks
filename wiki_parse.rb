# Wikipedia contains highly interconnected networks of information. Using a Breadth-First traversal,
# This script will find the minimum number of hops required to go from some starting wiki 
# some ending wiki.
#
# Authors: Joe Rodriguez, Joe Delia

require 'mechanize'


class WikiPage
  def initialize(k)
    @pageData = getPage(k)
    @seen     = false
    puts @pageData.body
  end

  # description - Retrieve the page data for a given wiki
  # TODO: Need error checking(ie. Page redirects, page missing, checking for variations of title)
  def getPage(param)
    url = 'http://en.wikipedia.org/w/api.php?' \
           'format=json&'\
           'action=query&'\
           'titles='+param+'&'\
           'prop=revisions&'\
           'rvprop=content'
    mechPage = Mechanize.new
    return mechPage.get(url)
  end

  #Retrieves references to the wikis located within a specific wiki's page
  def connections
    return []
  end

  def seen
    return @seen
  end 

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
  end



  #description - Run a BFS search from a given starting point until the end point is reached
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
      
      #Extract next wiki
      currentWiki    = q.pop

      #For each wiki located within the current wiki
      currentWiki.connections.each do |connectedWiki|
        #add a link from current wiki to connectedWiki
        #TODO: Decide on data structure to manage this
        
        #If connectedWiki hasn't been seen yet
        if connectedWiki.seen == false

          #Enqueue connected wiki and mark as seen
          q.push(connectedWiki)
          connectedWiki.setSeen(true)
        end
      end
    end
  end
end


r = Runner.new
r.run


#Display any anchor link that contains the keywork /wiki/
#page.links_with(href: /wiki/).each do |link|
#	puts link.href
