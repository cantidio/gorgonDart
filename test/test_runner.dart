/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'point2d_test.dart'    as point2d_test;
import 'mirroring_test.dart'  as mirroring_test;
import 'color_test.dart'      as color_test;
import 'sprite_test.dart'     as sprite_test;
import 'spritepack_test.dart' as spritepack_test;
import 'display_test.dart'    as display_test;

main()
{
  point2d_test.main();
  mirroring_test.main();
  color_test.main();
  display_test.main();
  sprite_test.main();
  spritepack_test.main();
  pollForDone(testCases);
}

pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}
