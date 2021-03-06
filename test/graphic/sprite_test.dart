/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library sprite_test;

import 'dart:async';
import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  group("Sprite",(){
    Sprite empty;
    Sprite normal;
    Sprite flipH;
    Sprite flipV;
    Sprite flipHV;
    Sprite rotateLeft;
    Sprite rotateRight;

    setUp((){
      empty       = new Sprite();
      normal      = new Sprite(imageSource: "resources/chico/chico_1.png");
      flipH       = new Sprite(imageSource: "resources/chico/chico_1_fh.png",   offset: new Point2D(-79,0));
      flipV       = new Sprite(imageSource: "resources/chico/chico_1_fv.png",   offset: new Point2D(0,-79));
      flipHV      = new Sprite(imageSource: "resources/chico/chico_1_fhv.png",  offset: new Point2D(-79,-79));
      rotateLeft  = new Sprite(imageSource: "resources/chico/chico_1_rl.png",   offset: new Point2D(0,-79));
      rotateRight = new Sprite(imageSource: "resources/chico/chico_1_rr.png",   offset: new Point2D(-79,0));

      return Future.wait([
        normal.onLoad,
        flipH.onLoad,
        flipV.onLoad,
        flipHV.onLoad,
        rotateLeft.onLoad,
        rotateRight.onLoad,
      ]);
    });


    test( "Empty width is 0", (){
      expect( empty.width     , equals( 0 ) );
    });

    test( "Empty height is 0", (){
      expect( empty.height    , equals( 0 ) );
    });

    test( "Empty offset is new Point2D.zero()", (){
      expect( empty.offset  , equals( new Point2D.zero() ) );
    });

    test( "Empty image is Sprite.emptyImage", (){
      expect( empty.image     , equals( Sprite.emptyImage ) );
    });

    test( "load with existent image results in a Sprite with an image != from Sprite.emptyImage", (){
      expect(normal.image, isNot(equals(Sprite.emptyImage)));
    });

    test( "load with inexistent image returns an exception", (){
      return empty.load("resources/logo_inexistent.png").catchError( (e) =>
        expect( e.toString(), equals( new Exception("Image: resources/logo_inexistent.png could not be found.").toString() ) )
      );
    });

    test( "Operator == must return true when comparing the same image.", (){
      expect( normal, equals(normal));
    });

    test( "Operator == return true when comparing sprites with the same internal data.", (){
      Sprite normal2 = new Sprite( imageSource: "resources/chico/chico_1.png");
      return normal2.onLoad.then((_) => expect( normal, equals(normal2)) );
    });

    test( "Flip horizontal.", (){
      return normal.flipH().then((_) => expect( normal, equals(flipH) ) );
    });

    test( "Flip vertical.", (){
      return normal.flipV().then((_) => expect( normal, equals(flipV) ) );
    });

    test( "Flip horizontal and vertical.", (){
      return normal.flipHV().then( (_) => expect( normal, equals(flipHV) ) );
    });

    test( "Flip generic with Mirroring.H", (){
      return normal.flip( Mirroring.H ).then( (_) => expect( normal, equals(flipH) ) );
    });

    test( "Flip generic with Mirroring.V", (){
      return normal.flip( Mirroring.V ).then( (_) => expect( normal, equals(flipV) ) );
    });

    test( "Flip generic with Mirroring.HV", (){
      return normal.flip( Mirroring.HV ).then( (_) => expect( normal, equals(flipHV) ) );
    });

    test( "Rotate Left", (){
      return normal.rotateLeft().then( (_) => expect( normal, equals(rotateLeft) ) );
    });

    test( "Rotate Right", (){
      return normal.rotateRight().then( (_) => expect( normal, equals(rotateRight) ) );
    });

  });
}
