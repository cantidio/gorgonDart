/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'point2d_test.dart'        as point2d_test;
import 'mirroring_test.dart'      as mirroring_test;
import 'color_test.dart'          as color_test;
import 'sprite_test.dart'         as sprite_test;
import 'spritepack_test.dart'     as spritepack_test;
import 'display_test.dart'        as display_test;
import 'font_alignment_test.dart' as font_alignment_test;
import 'font_test.dart'           as font_test;

main()
{
  point2d_test.main();
  mirroring_test.main();
  color_test.main();
  display_test.main();
  font_alignment_test.main();
  font_test.main();
  sprite_test.main();
  spritepack_test.main();
  pollForDone(testCases);

  /*Element content = new Element.tag("div");
  document.body.append(content);
  Display display = new Display(content);

  SpritePack spr = new SpritePack.fromTileSheet("resources/chico/chico.png", 79, 79, new Point2D(32,64));
  int f = 0;
  spr.onLoad.then((_){
    /*Timer timer = new Timer.periodic( const Duration(milliseconds: 10), (_) {
      display.clear();
      spr[f].draw(new Point2D(50,10));
      f++;
      if(f>=spr.length)f=0;
    });*/
    for( int i = 0; i < spr.length; ++i )
    {
      document.body.append(spr[i].image);
    }
  });*/
}

pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}
