/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library animation_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  group("Animation",(){
    Animation empty;
    Animation normal;
    Animation mapped_empty;
    Animation mapped_normal;

    setUp((){
      empty   = new Animation();
      normal  = new Animation
      (
        looping:      true,
        loopFrame:    10,
        repeatNumber: 5,
        frames:       [new Frame(group:"g1"),new Frame(group:"g2")]
      );
      mapped_empty = new Animation.fromMap({});
      mapped_normal = new Animation.fromMap
      ({
        "looping":    true,
        "loopFrame":    10,
        "repeatNumber": 5,
        "frames":       [{"group":"g1"},{"group":"g2"}]
      });
    });

    test("When using the Empty Constructor the  Animation.looping is false",(){
      expect(empty.looping, equals(false));
    });

    test("When using the Empty Constructor the  Animation.loopFrame is 0",(){
      expect(empty.loopFrame, equals(0));
    });

    test("When using the Empty Constructor the  Animation.repeatNumber is -1",(){
      expect(empty.repeatNumber, equals(-1));
    });

    test("When using the Empty Constructor the  Animation.length is false",(){
      expect(empty.length, equals(0));
    });

    test("When using the Constructor setting the looping=true the  Animation.looping is true",(){
      expect(normal.looping, equals(true));
    });

    test("When using the Constructor setting the loopFrame=10 the Animation.loopFrame is 10",(){
      expect(normal.loopFrame, equals(10));
    });

    test("When using the Constructor setting the repeatNumber=5 the Animation.repeatNumber is 5",(){
      expect(normal.repeatNumber, equals(5));
    });

    test("When using the Constructor setting the frames=[new Frame(),new Frame()] Animation.length is 2",(){
      expect(normal.length, equals(2));
    });

    test("When using the Constructor setting the frames=[new Frame(group:'g1'),new Frame(group:'g2')] animation[0].group is 'g1'",(){
      expect(normal[0].group, equals("g1"));
    });

    test("When using the Constructor setting the frames=[new Frame(group:'g1'),new Frame(group:'g2')] animation[1].group is 'g2'",(){
      expect(normal[1].group, equals("g2"));
    });

    test("When using the Constructor .fromMap with an empty Map the  Animation.looping is false",(){
      expect(mapped_empty.looping, equals(false));
    });

    test("When using the Constructor .fromMap with an empty Map the  Animation.loopFrame is 0",(){
      expect(mapped_empty.loopFrame, equals(0));
    });

    test("When using the Constructor .fromMap with an empty Map the  Animation.repeatNumber is -1",(){
      expect(mapped_empty.repeatNumber, equals(-1));
    });

    test("When using the Constructor .fromMap with an empty Map the  Animation.length is false",(){
      expect(mapped_empty.length, equals(0));
    });

    test("When using the Constructor .fromMap and setting the looping=true the  Animation.looping is true",(){
      expect(mapped_normal.looping, equals(true));
    });

    test("When using the Constructor .fromMap and setting the loopFrame=10 the Animation.loopFrame is 10",(){
      expect(mapped_normal.loopFrame, equals(10));
    });

    test("When using the Constructor .fromMap and setting the repeatNumber=5 the Animation.repeatNumber is 5",(){
      expect(mapped_normal.repeatNumber, equals(5));
    });

    test("When using the Constructor .fromMap and setting the frames=[new Frame(),new Frame()] Animation.length is 2",(){
      expect(mapped_normal.length, equals(2));
    });

    test("When using the Constructor .fromMap and setting the frames=[{'group':'g1'},{'group':'g2'}] animation[0].group is 'g1'",(){
      expect(mapped_normal[0].group, equals("g1"));
    });

    test("When using the Constructor .fromMap and setting the frames=[{'group':'g1'},{'group':'g2'}] animation[1].group is 'g2'",(){
      expect(mapped_normal[1].group, equals("g2"));
    });

    test("Using the forEach must call the desired function for each frame in the animation.",(){
      var frames = [normal[1],normal[0]];
      normal.forEachFrame( (f){
        expect(f,equals(frames.removeLast()));
      } );
      expect(frames.length, equals(0));
    });

    test("When Using the add method in an empty animation the animation.length must increase by 1.",(){
      int before = empty.length;
      empty.add(new Frame());
      expect(empty.length, equals(before + 1));
    });

    test("When Using the add method in an empty animation the animation[0] must contain the added frame.",(){
      Frame frame = new Frame();
      empty.add(frame);
      expect( empty[0], equals(frame));
    });

    test("When Using the add method in an animation with 2 frames and setting the index to 0, the animation[0] must contain the added frame.",(){
      Frame frame = new Frame();
      normal.add(frame,0);
      expect( normal[0], equals(frame));
    });

    test("When Using the add method in an animation with 2 frames and setting the index to 3 throws an RangeError.",(){
      expect(()=> normal.add(new Frame(),3), throwsRangeError);
    });

    test("After Using the remove method in an animation, the animation.length must decrease by 1.",(){
      int before = normal.length;
      normal.remove(normal[0]);
      expect( normal.length, equals(before-1) );
    });

    test("After Using the remove method in an animation, only the requested frame must be removed.",(){
      Frame removed = normal[0];
      normal.remove(normal[0]);
      normal.forEachFrame((frame){
        expect(removed, isNot(equals(frame)));
      });
    });

    test("After Using the removeAt method in an animation, the animation.length must decrease by 1.",(){
      int before = normal.length;
      normal.removeAt( 0 );
      expect( normal.length, equals(before-1) );
    });

    test("After Using the removeAt method in an animation, and setting the index to 0, removes only the frame at the position 0.",(){
      Frame removed = normal[0];
      normal.removeAt(0);
      normal.forEachFrame((frame){
        expect(removed, isNot(equals(frame)));
      });
    });

    test("When Using the removeAt method in an animation with 2 frames and setting the index to 3 throws an RangeError.",(){
      expect(()=> normal.removeAt(3), throwsRangeError);
    });

  });
}