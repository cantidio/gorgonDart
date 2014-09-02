/**
 * Copyright (C) 2014 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';

main()
{
  Display display = new Display( query("#display"), width: 640, height: 480 );
  Spritepack sp = new Spritepack.fromJSON("resources/chico/chico.json");
  Animationpack ap = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");
  Sound normal = new Sound(soundUrl: "resources/chico/attack.wav");
  Animator anim = new Animator(sp,ap);
  normal.onLoad.then((_){
    normal.play();
  });
  sp.onLoad.then((_){
    num ang = 0.0;
    num scale = 1.0;
    int scale_mod = 1;

      anim.changeAnimation("walk");
      Timer timer = new Timer.periodic( const Duration(milliseconds: 1000~/60), (_) {
         display.clear();
         anim.runStep();
         anim.draw(new Point2D(180,180), rotation: ang, scale: scale);
         ang += 0.8;
         scale += 0.05 * scale_mod;
         if(scale >= 3.0) scale_mod = -1;
         if(scale <= 0.5) scale_mod = 1;
      });
  });
}
