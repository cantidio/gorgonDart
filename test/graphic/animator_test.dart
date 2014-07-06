/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library animator_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";
import "dart:async";

void main()
{
  group("Animator",(){
    Animator empty;
    Animator normal;
    Animationpack anim;

    setUp((){
      anim  = new Animationpack.fromMap
      ({
        "walk": {
          "looping":      true,
          "loopFrame":    0,
          "repeatNumber": -1,
          "time":         6,
          "frames": [
             { "group": "walk", "index": 0 },
             { "group": "walk", "index": 1 },
             { "group": "walk", "index": 2 },
             { "group": "walk", "index": 3 },
             { "group": "walk", "index": 4 },
             { "group": "walk", "index": 3 },
             { "group": "walk", "index": 2 },
             { "group": "walk", "index": 1 }
           ]
        },
        "stuck_at_0":{
          "frames": [
             { "group": "walk", "index": 0, "time": 0 },
             { "group": "walk", "index": 1, "time": 10 }
           ]
        },
        "next_frame":{
          "frames": [
             { "group": "walk", "index": 0, "time": 1 },
             { "group": "walk", "index": 1, "time": 1 }
           ]
        },
        "with_looping":{
          "looping":  true,
          "frames": [
             { "group": "walk", "index": 0, "time": 1 },
             { "group": "walk", "index": 1, "time": 1 },
             { "group": "walk", "index": 2, "time": 1 }
           ]
        }
      });
      Spritepack    spr   = new Spritepack.fromJSON("resources/chico/chico.json");

      empty   = new Animator( new Spritepack(), new Animationpack() );
      normal  = new Animator( spr, anim );

      return Future.wait([ anim.onLoad, spr.onLoad ]);
    });

    test("When using the Animator Constructor with an empty Animationpack, the  Animator.animationOn is null.",(){
      expect(empty.animationOn, equals(null));
    });

    test("When using the Animator Constructor with a normal Animationpack, the  Animator.animationOn is the first animation of the pack.",(){
      expect(normal.animationOn, equals( anim.animations[0] ));
    });

    test("When using the Constructor, the  Animator.timeOn is 0.",(){
      expect(empty.timeOn, equals(0));
    });

    test("When using the Constructor, the  Animator.frameOn is 0.",(){
      expect(empty.frameOn, equals(0));
    });

    test("When using the Constructor, the  Animator.loopOn is 0.",(){
      expect(empty.loopOn, equals(0));
    });

    test("When using the Constructor, the  Animator.isPaused is false.",(){
      expect(empty.isPaused, equals(false));
    });

    test("When using the Constructor, the  Animator.isPlaying is true.",(){
      expect(empty.isPlaying, equals(true));
    });

    test("After using the Animator.pause(), the isPaused is true.",(){
      empty.pause();
      expect(empty.isPaused, equals(true));
    });

    test("After using the Animator.resume() when paused, the isPaused is false.",(){
      empty.pause();
      empty.resume();
      expect(empty.isPaused, equals(false));
    });

    test("After using runStep when the time of frameOn is 6 and the timeOn=0, the timeOn is incresed by 1.",(){
      normal.changeAnimation("walk");
      int before = normal.timeOn;
      normal.runStep();
      expect(normal.timeOn, equals( before + 1 ));
    });

    test("After using runStep when the time of frameOn is 0, the timeOn keeps it's initial value.",(){
      normal.changeAnimation("stuck_at_0");
      int before = normal.timeOn;
      normal.runStep();

      expect(normal.timeOn, equals( before ));
    });

    test("After using runStep when the time of frameOn is 0, the frameOn keeps it's initial value.",(){
      normal.changeAnimation("stuck_at_0");
      int before = normal.frameOn;
      normal.runStep();

      expect(normal.frameOn, equals( before ));
    });

    test("After using runStep when the time of frameOn is 1 and the timeOn is 1, the frameOn is incresed by 1.",(){
      normal.changeAnimation("next_frame");
      int before = normal.frameOn;
      normal.runStep(); // timeOn = 1
      normal.runStep();

      expect(normal.frameOn, equals( before+1 ));
    });

    test("The runStep must be called N times before frameOn increses, the N is equal to the current frame.time.",(){
      normal.changeAnimation("walk");
      int expected  = anim["walk"][normal.frameOn].time;
      int runned = 0;
      for( int i = normal.frameOn; i == normal.frameOn; runned++,normal.runStep() ); //runs to the next frame
      --runned;

      expect( runned , equals( expected ));
    });

    test("After using runStep when the time of frameOn is 1 and the timeOn is 1, the timeOn returns to 0.",(){
      normal.changeAnimation("next_frame");
      int before = normal.frameOn;
      normal.runStep(); // timeOn = 1
      normal.runStep();

      expect(normal.timeOn, equals( 0 ));
    });

    test("After using runStep when in the last frame and time of an animation with looping=false, the frame remains the same.",(){
      normal.changeAnimation("next_frame");
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      normal.runStep();             // frame 2 timeOn = 1
      normal.runStep();

      expect(normal.frameOn, equals( 1 ));
    });

    test("After using runStep when in the last frame and time of an animation with looping=false, the timeOn remains the same.",(){
      normal.changeAnimation("next_frame");
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      normal.runStep();             // frame 2 timeOn = 1
      normal.runStep();

      expect(normal.timeOn, equals( 1 ));
    });

    test("After using runStep when in the last frame and time of an animation with looping=true and loopFrame=0, the frameOn returns to 0.",(){
      normal.changeAnimation("with_looping");
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      normal.runStep();             // frame 2 timeOn = 1
      normal.runStep();

      expect(normal.frameOn, equals( 0 ));
    });

    test("After using runStep when in the last frame and time of an animation with looping=true, the timeOn returns to 0.",(){
      normal.changeAnimation("with_looping");
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      for( int i = normal.frameOn; i == normal.frameOn; normal.runStep() ); //runs to the next frame
      normal.runStep();
      normal.runStep();

      expect(normal.timeOn, equals( 0 ));
    });

  });
}