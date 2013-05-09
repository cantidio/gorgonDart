#!/bin/bash -e

analysis=$(dart_analyzer src/*.dart)
echo -e "$analysis"
if [[ "$results" != "" ]]
  then exit 1
fi

# run a set of Dart Unit tests

results=$(DumpRenderTree test/test_test_runner.html)
echo -e "$results"

# check to see if DumpRenderTree tests
# fails, since it always returns 0
if [[ "$results" == *"Some tests failed"* ]]
then
  exit 1
fi

exit 0