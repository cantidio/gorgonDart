# Copyright (C) 2013 Cantidio Fontes
# For conditions of distribution and use, see copyright notice in LICENSE.txt
#
#!/bin/bash -e

analysis=$(dartanalyzer lib/*.dart lib/src/*/*.dart)
echo -e "$analysis"
if [[ "$results" != "" ]]
  then exit 1
fi

# run a set of Dart Unit tests

results=$(DumpRenderTree test/test_runner.html)
echo -e "$results"

# check to see if DumpRenderTree tests
# fails, since it always returns 0
if [[ "$results" == *"Some tests failed"* ]]
then
  exit 1
fi

# generate documentation, for this to work zip must be installed

mkdir ./docs
dartdoc --out=./docs ./lib/gorgon.dart
cd docs
#tar -cvf ../gorgon_docs.tar * 
zip -r ../gorgon_docs *

exit 0
