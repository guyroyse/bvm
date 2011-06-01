BVM (Big Visible Metrics)
=========================

BVM helps you generate Big Visible Charts of Sonar Code Metrics for your teamspace.  It is a simple command line utility that parses the data exposed as XML via the Sonar API.  It converts this XML into CSV data that is consumable using [Microsoft Treemapper](http://research.microsoft.com/en-us/downloads/3f3ed95e-26d8-4616-a06c-b609df29756f/default.aspx) or a tool of your choice.  

Installing
----------

Installation is super easy.  Just enter:

    gem install bvm

Once it is installed, you may also want to install Microsoft Treemapper.  Download it from Microsoft's [site](http://research.microsoft.com/en-us/downloads/3f3ed95e-26d8-4616-a06c-b609df29756f/default.aspx) and follow the installation instructions.

Typical Usage
-------------

This sample generates a CSV file ready for Microsoft Treemapper to use against the Apache's Maven source.  The size of the box represents the numbers of lines of code (the ncloc metric) in the class and the color reflects the cyclomatic complextiy.  In this case, a complexity of 50 is the threshhold between red and green on the chart. 

    curl -X GET "http://nemo.sonarsource.org/api/resources?resource=99176&metrics=ncloc,complexity&depth=-1&qualifiers=CLA&format=xml" | bvm --jar maven --color complexity --invert-color --color-adjust 50 > maven-complexity.csv

This generates a similar data set for code coverage.  In this case, the coverage threshhold is set to 80%.

    curl -X GET "http://nemo.sonarsource.org/api/resources?resource=99176&metrics=ncloc,coverage&depth=-1&qualifiers=CLA&format=xml" | bvm --jar maven --color coverage --color-adjust 80 > maven-coverage.csv

The Details
-----------

The CSV content that BVM generates consists of the following format:

    <size_metric>,<color_metric>,<jar_name>,<package_name>,<class_name>

The size metric is self-explanitory.  It's the size of the box to be generated.  By default is it set to ncloc and this is probably what you will always want.  I can be changed using the --size switch and specifing a different Sonar metric.

The color metric defaults to coverage.  You will probably want this to be several differnt values, depending on the charts you want to generate.  It can be sepcified using the --color switch.

Microsoft Treemapper expects that negative numbers are red and positive numbers are green but our metrics aren't quite so compliant.  The --invert-color swtich will mulitply the specified color metric by -1 to accomodate the charts you are trying to create.  Furthermore, the --color-adjust switch can be given a number that will be added to the specified metric before being outputed.  This allows us to set threshholds of tolerance for our charts.

The JAR name is really just the project name.  If you have multiple JARs in your project (and who doesn't) then the --jar switch will allow you to group them all into one file and generate one enourmous view of your entire codebase.  It defaults to "jar" and you probably always want to override it.

If your command line savy you probably noticed that BVM does not actually operate on files.  It reads STDIN and writes STDOUT.

Copyright
---------

Copyright (c) 2011 Guy Royse & Alyssa Diaz. See LICENSE for further details.
