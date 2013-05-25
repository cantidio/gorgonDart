/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library color_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  group("Frame",(){
    Frame empty;
    Frame normal;
    Frame mapped_empty;
    Frame mapped_normal;

    setUp((){
      empty   = new Frame();
      normal  = new Frame
      (
        group:      "group1",
        index:      10,
        time:       5,
        offset:     new Point2D(12,34),
        mirroring:  Mirroring.H,
        rotation:   66
      );
      mapped_empty   = new Frame.fromMap({});
      mapped_normal  = new Frame.fromMap
      ({
        "group":      "group1",
        "index":      10,
        "time":       5,
        "xoffset" :   12,
        "yoffset":    34,
        "mirroring":  "H",
        "rotation":   66
      });

    });

    test("When using the Empty Constructor the frame.group is ''",(){
      expect(empty.group, equals( "" ));
    });

    test("When using the Empty Constructor the frame.index is 0",(){
      expect(empty.index, equals( 0 ));
    });

    test("When using the Empty Constructor the frame.time is 0",(){
      expect(empty.time, equals( 0 ));
    });

    test("When using the Empty Constructor the frame.offset is new Point2D.zero()",(){
      expect(empty.offset, equals( new Point2D.zero() ));
    });

    test("When using the Empty Constructor the frame.mirroring is Mirroring.None",(){
      expect(empty.mirroring, equals( Mirroring.None ));
    });

    test("When using the Empty Constructor the frame.rotation is 0",(){
      expect(empty.rotation, equals( 0 ));
    });

    test("When using the Constructor setting the group='group1' the frame.group is 'group1'",(){
      expect(normal.group, equals( "group1" ));
    });

    test("When using the Constructor setting the index=10 the frame.index is 10",(){
      expect(normal.index, equals( 10 ));
    });

    test("When using the Constructor setting the time=5 the frame.time is 5",(){
      expect(normal.time, equals( 5 ));
    });

    test("When using the Constructor setting the offset=new Point2D(12,34) the frame.offset is new Point2D(12,34)",(){
      expect(normal.offset, equals( new Point2D(12,34) ));
    });

    test("When using the Constructor setting the mirroring=Mirroring.H the frame.mirroring is Mirroring.H",(){
      expect(normal.mirroring, equals( Mirroring.H ));
    });

    test("When using the Constructor setting the rotation=66 the frame.rotation is 66",(){
      expect(normal.rotation, equals( 66 ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.group is ''",(){
      expect(mapped_empty.group, equals( "" ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.index is 0",(){
      expect(mapped_empty.index, equals( 0 ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.time is 0",(){
      expect(mapped_empty.time, equals( 0 ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.offset is new Point2D.zero()",(){
      expect(mapped_empty.offset, equals( new Point2D.zero() ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.mirroring is Mirroring.None",(){
      expect(mapped_empty.mirroring, equals( Mirroring.None ));
    });

    test("When using the Constructor .fromMap with an empty Map the frame.rotation is 0",(){
      expect(mapped_empty.rotation, equals( 0 ));
    });

    test("When using the Constructor .fromMap and setting the group='group1' the frame.group is 'group1'",(){
      expect(mapped_normal.group, equals( "group1" ));
    });

    test("When using the Constructor .fromMap and setting the index=10 the frame.index is 10",(){
      expect(mapped_normal.index, equals( 10 ));
    });

    test("When using the Constructor .fromMap and setting the time=5 the frame.time is 5",(){
      expect(mapped_normal.time, equals( 5 ));
    });

    test("When using the Constructor .fromMap and setting the xoffset=12 the frame.offset.x is 12",(){
      expect(mapped_normal.offset.x, equals( 12 ));
    });

    test("When using the Constructor .fromMap and setting the yoffset=34 the frame.offset.y is 34",(){
      expect(mapped_normal.offset.y, equals( 34 ));
    });

    test("When using the Constructor .fromMap and setting the mirroring=Mirroring.H the frame.mirroring is Mirroring.H",(){
      expect(mapped_normal.mirroring, equals( Mirroring.H ));
    });

    test("When using the Constructor .fromMap and setting the rotation=66 the frame.rotation is 66",(){
      expect(mapped_normal.rotation, equals( 66 ));
    });

  });
}