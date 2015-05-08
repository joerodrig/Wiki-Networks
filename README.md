<h1>Summary</h1>
<p>Wikipedia contains highly interconnected networks of information. Using Ruby and the Wikipedia API, users can build a network of interrelated wiki pages based off of some arbitrary starting wiki.</p>

<h1>How to Run</h1>

<p><b>Output to a GraphViz compatible file: </b></p>
```ruby lib/wikiParse.rb {iterations} {rootWikipage} {pointsToSearch}  > output.dot```
<ul>

<li><b>iterations</b>  -->  The iterations parameter tells the system how far off it should
commit to the BFS from the root wiki. For example, if the iterations parameter is set to two,
the BFS will end after parsing each wiki that is no more than two hops away from the root wiki</li>
<li><b>rootWikipage</b>  --> Starting wikipage. </li>
<li><b>pointsToSearch</b> --> Optional parameter. Stops the BFS if the number of points to search is reached
</li>
</ul>


<p><b>Parse GraphViz compatible file into JSON File:</b></p>
```ruby lib/file_to_json.rb {filePath} > jfile.json```
<ul>

<li><b>filePath</b> --> The filePath parameter tells the system how to access the .dot file to be
converted into a json file.</li>
</ul>

<h1>Running the Visualizations in Graphviz </h1>
<p> To run the visualizations you need GraphViz to compile and display the networks</p>
<p> GraphViz can be installed <a href="http://www.graphviz.org/">here</a></p>

<p> Once you have GraphViz installed, to compile the network, enter:</p>
```neato -Tps <DOT_FILE_HERE>.dot -o <OUTPUT_NAME_HERE>.ps```

<p> Once the visual finishes compiling, enter: </p>
```open <OUTPUT_NAME_HERE>.ps```
<h1> Dependencies </h1>
<ul>
<li>rSpec</li>
<li>json</li>
<li>mechanize</li>
</ul>