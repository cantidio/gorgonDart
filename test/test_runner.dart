/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';

import 'graphic/test.dart'       as graphic;
import 'audio/test.dart'         as audio;
import 'input/test.dart'       as input;

import 'package:gorgon/gorgon.dart';
import 'dart:html';
main()
{
  useHtmlConfiguration();
  graphic.main();
  audio.main();
  input.main();

//  Display display = new Display( query("#display"), width: 320, height: 240 );
//  Spritepack sp = new Spritepack.fromSpriteSheet("resources/chico/chico.png", {
//    "walk":[
//      { "xstart": 0, "ystart":0, "width": 79, "height": 79, "xoffset" : -32, "yoffset" : -64 },
//      { "xstart": 79, "ystart":20, "width": 79, "height": 39, "xoffset" : -32, "yoffset" : -44 },]
//  });
//  sp.onLoad.then((_){
//    int line=1;
//    sp.forEachSprite((s){
//      s.flipHV().then((sr){
//        sr.draw(new Point2D(80,line* 80));
//        line++;
//      });
//    });
//  });

}
