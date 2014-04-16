# Copyright (C) 2013 Cantidio Fontes
# For conditions of distribution and use, see copyright notice in LICENSE.txt
#
#!/bin/bash -e

# run a set of Dart Unit tests
which content_shell
if [[ $? -ne 0 ]]; then
  $DART_SDK/../chromium/download_contentshell.sh
  unzip content_shell-linux-x64-release.zip

  cs_path=$(ls -d drt-*)
  PATH=$cs_path:$PATH
fi
results=$(content_shell --dump-render-tree test/test_runner.html 2>&1)
echo -e "$results"

# check to see if DumpRenderTree tests
# fails, since it always returns 0
if [[ "$results" == *"Some tests failed"* ]]
then
  exit 1
fi

# generate documentation, for this to work zip must be installed

#mkdir ./docs
#dartdoc --out=./docs ./lib/gorgon.dart
#cd docs
#tar -cvf ../gorgon_docs.tar *
#zip -r ../gorgon_docs *

exit 0
