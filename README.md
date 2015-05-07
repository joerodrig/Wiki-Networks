<h1>Summary</h1>
<p>Wikipedia contains highly interconnected networks of information. Using Ruby and the Wikipedia API, users can build a network of interrelated wiki pages based off of some arbitrary starting wiki.</p>

<h1>How to Run</h1>

<p>Output to a GraphViz compatible file: </p>
```ruby lib/wikiParse.rb {iterations} {rootWikipage} {pointsToSearch}  > output.dot```
<ul>

<li><b>iterations</b>  -->  The iterations parameter tells the system how far off it should
commit to the BFS from the root wiki. For example, if the iterations parameter is set to two,
the BFS will end after parsing each wiki that is no more than two hops away from the root wiki</li>
<li><b>rootWikipage</b>  --> Starting wikipage. </li>
<li><b>pointsToSearch</b> --> Optional parameter. Stops the BFS if the number of points to search is reached
</li>
</ul>

<p>Parse GraphViz compatible file into JSON File: </p>
```ruby lib/file_to_json.rb {filePath} > jfile.json```
<ul>

<li><b>filePath</b> --> The filePath parameter tells the system how to access the .dot file to be
converted into a json file.</li>
</ul>

<h1> Dependencies </h1>
<ul>
<li>rSpec</li>
<li>json</li>
<li>mechanize</li>
</ul>