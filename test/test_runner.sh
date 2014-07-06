# Copyright (C) 2013 Cantidio Fontes
# For conditions of distribution and use, see copyright notice in LICENSE.txt
#
#!/bin/bash -e
which content_shell
if [[ $? -ne 0 ]]; then
  $DART_SDK/../chromium/download_contentshell.sh
  unzip content_shell-linux-x64-release.zip

  cs_path=$(ls -d drt-*)
  PATH=$cs_path:$PATH
fi

#content_shell --dump-render-tree test_runner.html
results=$(content_shell --dump-render-tree test/test_runner.html)
s=$?
echo "code: $s"
echo -e "$results"
