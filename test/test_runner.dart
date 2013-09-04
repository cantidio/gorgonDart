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
import 'animator_test.dart'       as animator_test;

import 'audio_instance_test.dart' as audio_instance_test;
import 'sound_test.dart'          as sound_test;
import 'audio_channel_test.dart'  as audio_channel_test;
import 'audio_system_test.dart'   as audio_system_test;

import 'keyboard_test.dart'       as keyboard_test;

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
  animator_test.main();
  audio_system_test.main();
  audio_channel_test.main();
  audio_instance_test.main();
  sound_test.main();
  keyboard_test.main();

  pollForDone(testCases);

  /*Keyboard a = new Keyboard();
  a.onKeyDown.listen((e) {
    if( a[KeyCode.A] && a[KeyCode.B] )
    {
      print("A + B");
    }
  });

  AudioSystem system = new AudioSystem();
  system.targetChannel.gain = 1.0;

  Sound sound = new Sound( soundUrl: "resources/chico/attack.wav");
  sound.onLoad.then((s) {

    Timer timer;
    timer = new Timer.periodic( const Duration(milliseconds: 10000~/70), (_) {
      s.play();
      system.targetChannel.gain -= 0.03;

      if( system.targetChannel.gain <= 0 )
        timer.cancel();
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
