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
import 'frame_test.dart'          as frame_test;
import 'animation_test.dart'      as animation_test;
import 'animationpack_test.dart'  as animationpack_test;

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
  frame_test.main();
  animation_test.main();
  animationpack_test.main();
  pollForDone(testCases);

  /*Element content = new Element.tag("div");
  document.body.append(content);
  Display display = new Display(content, width:400,height:400);
int ang = 0;
int alpha = 255;
num scale =1;
int scaleMod = 1;

int mirror=0;

  Spritepack spr = new Spritepack.fromJSON("resources/chico/chico.json");
  Animationpack ani = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");
  AnimationHandler handler;
  int f = 0;
  Future.wait([spr.onLoad,ani.onLoad]).then((_){

    handler = new AnimationHandler(spr, ani);
    handler.sanityCheck();
    handler.changeAnimation("walk");
    Timer timer = new Timer.periodic( const Duration(milliseconds: 1000~/60), (_) {
      display.clear();
      handler.runStep();
      handler.draw(new Point2D(150,100), rotation: ang++, alpha:alpha, scale:scale);
      alpha-= 10;
      if(alpha <=100) alpha = 255;

      scale += scaleMod*0.01;
      if( scale >= 2 || scale <= 0.25 ) scaleMod *= -1;

    });
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
