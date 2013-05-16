# Copyright (C) 2013 Cantidio Fontes
# For conditions of distribution and use, see copyright notice in LICENSE.txt
#
#!/bin/bash -e

analysis=$(dart_analyzer lib/*.dart lib/src/*/*.dart)
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

exit 0
