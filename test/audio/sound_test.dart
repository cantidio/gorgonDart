/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library sound_test;

import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';

void main()
{
  group("Sound",(){
    Sound empty;
    Sound normal;

    setUp((){
      empty  = new Sound();
      normal = new Sound(soundUrl: "resources/chico/attack.wav");

      return normal.onLoad;
    });

    test("Empty constructor, channel is AudioSystem.targetChannel",(){
      Sound sound = new Sound();
      expect( sound.channel, equals( new AudioSystem().targetChannel ) );
    });

    test("Empty constructor, duration is 0.0",(){

      Sound sound = new Sound();
      expect( sound.duration, equals( 0.0 ) );
    });

    test("Empty constructor, gain is 1.0",(){

      Sound sound = new Sound();
      expect( sound.gain, equals( 1.0 ) );
    });

    test("When setting the gain, it must return the corrected setted value.",(){
      normal.gain = 0.5;
      expect( normal.gain, 0.5);
    });

    test( "Try to load an inexistent sound returns an exception",(){
      String file = "this_sound_do_not_exist.wav";
      Sound sound = new Sound();
      expect(sound.load( file ), throws);
    });

    test( "When Loading a normal sound must call the future.",(){
      String file = "resources/chico/attack.wav";
      Sound sound = new Sound();
      return sound.load(file).then((s)=> expect(s, equals(sound)));
    });

    test( "When playing a sound, must return an valid AudioInstance.", (){
      AudioInstance instance = normal.play();
      expect( instance, isNotNull );
    });

    test( "When playing a sound, must return an AudioInstance that is playing or scheduled to be played.", (){
      AudioInstance instance = normal.play();
      expect( instance.isPlaying, isTrue );
    });

  });
}
