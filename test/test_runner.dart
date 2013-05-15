/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';

import 'point_test.dart'      as point_test;
import 'mirroring_test.dart'  as mirroring_test;
import 'color_test.dart'      as color_test;
import 'sprite_test.dart'     as sprite_test;

main()
{
  point_test.main();
  mirroring_test.main();
  color_test.main();
  sprite_test.main();

  runTests();

  /*Sprite logo = new Sprite( imageSource: "resources/logo.png");

  logo.onLoad
    .then((_) => logo.flipV())
    .then((_) => logo.flipH())
    .then((_) => logo.rotateRight())
    .then((_) => logo.rotateRight())
    .then((_) { query("#content").append(logo.image);} );*/


}
