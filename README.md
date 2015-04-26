<h1>Summary</h1>
<p>Wikipedia contains highly interconnected networks of information. Using Ruby and the Wikipedia API, we can allow a user to enter arbitrary starting and ending points and count the amount of “hops” it takes for us to go from start → end between wiki articles</p>

<p>Our ultimate goal is to port this system into a Web-Application using Ruby-On-Rails as our web framework and using a graph library such as D3 or ngraph, visualize the paths taken from Start -> End of our scraper. </p>


<h1>How to Run</h1>
<p> ruby lib/wikiParse.rb {FROM} -> {TO} </p>
<p> From = Starting point </p>
<p> To   = Ending point </p>

<h1> Dependencies </h1>
<ul>
<li>rSpec</li>
<li>json</li>
<li>mechanize</li>