/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library sound_test;

import 'dart:async';
import "package:unittest/unittest.dart";

import 'package:gorgon/gorgon.dart';

void main()
{
  group("Sound",(){
    Sound empty;
    Sound normal;


    setUp((){
      empty = new Sound();
      normal = new Sound();
    });
    test("Empty constructor, channel is AudioSystem.targetChannel",(){

      Sound sound = new Sound();
      expect( sound.channel, equals( new AudioSystem().targetChannel ) );
    });

    test("Empty constructor, duration is 0.0",(){

      Sound sound = new Sound();
      expect( sound.duration, equals( 0.0 ) );
    });

    test("Empty constructor, gain is 0.0",(){

      Sound sound = new Sound();
      expect( sound.gain, equals( 0.0 ) );
    });

    test( "Try to load an inexistent sound returns an exception",(){
      String file = "this_sound_do_not_exist.wav";
      Sound sound = new Sound();
      sound.load( file ).catchError( expectAsync1((e) {
        expect( e.toString(), equals( new Exception("Sound: Error when decoding $file.").toString() ) );
      }));
    });

    test( "When Loading a normal sound must call the future.",(){
      String file = "resources/chico/attack.wav";
      Sound sound = new Sound();
      sound.load( file )
        .then( expectAsync1( (e){} ) )
        .catchError( protectAsync1( (e) => expect(true, isFalse, reason: "Should not be reached.") ) );
    });

  });
}