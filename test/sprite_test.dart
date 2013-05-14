/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
library sprite_test;

import 'dart:async';
import "package:unittest/unittest.dart";

import 'package:gorgon/gorgon.dart';

void main()
{
  test( "Sprite Empty", (){
      Sprite empty = new Sprite();
  
      expect( empty.width, equals( 0 ) );
      expect( empty.height, equals( 0 ) );
      expect( empty.image, equals( Sprite.emptyImage ) );
      expect( empty.offset.x, equals( 0 ) );
      expect( empty.offset.y, equals( 0 ) );
  });
  
  test( "Sprite Operator ==", (){
      Sprite logo1 = new Sprite( imageSource: "resources/logo.png");
      Sprite logo2 = new Sprite( imageSource: "resources/logo.png");
      
      Future.wait([ logo1.onLoad, logo2.onLoad ]).then( expectAsync1( (_) => expect( logo1, equals(logo2) ) ));
  });
  
  test( "Sprite RotateLeft", (){
        Sprite logo1 = new Sprite( imageSource: "resources/logo.png", offset: new Point.zero() );
        Sprite logo2 = new Sprite( imageSource: "resources/logo_rl.png", offset: new Point(0.0, -390.0) );
        
        Future.wait([ logo1.onLoad, logo2.onLoad ])
          .then( (_) => logo1.rotateLeft() )
          .then( expectAsync1( (_) => expect( logo1, equals(logo2) ) ));
    });
  
  test( "Sprite RotateRight", (){
    Sprite logo1 = new Sprite( imageSource: "resources/logo.png", offset: new Point.zero() );
    Sprite logo2 = new Sprite( imageSource: "resources/logo_rr.png", offset: new Point(-394.0, 0.0) );
    
    Future.wait([ logo1.onLoad, logo2.onLoad ])
    .then( (_) => logo1.rotateRight() )
    .then( expectAsync1( (_) => expect( logo1, equals(logo2) ) ));
  });
  
}