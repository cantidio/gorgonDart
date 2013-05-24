/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library spritepack_test;

import 'dart:async';
import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  group("SpritePack",(){
    Spritepack empty;
    Spritepack chicoNormal;
    Spritepack chicoTile;
    Spritepack chicoJSON;

    setUp((){
      List<Future<dynamic>> futures  = new List<Future<dynamic>>();

      empty       = new Spritepack();
      chicoNormal = new Spritepack();
      for( int i = 1; i < 21; ++ i )
      {
        Sprite spr = new Sprite(imageSource:"resources/chico/chico_$i.png", offset: new Point2D.zero());
        futures.add( spr.onLoad );
        chicoNormal.add( spr );
      }
      chicoTile = new Spritepack.fromTileSheet("resources/chico/chico.png", 79, 79, new Point2D.zero());
      futures.add(chicoTile.onLoad);

      chicoJSON = new Spritepack.fromJSON( "resources/chico/chico.json");
      futures.add(chicoJSON.onLoad);

      return Future.wait(futures);
    });

    test( "Empty length is 0", (){
      expect( empty.length    , equals( 0 ) );
    });

    test( "Empty accessing sprite at [0] throws RangeError.", (){
      expect( () => empty["0"][0], throwsRangeError );
    });

    test( "Accessing inexistent sprite groups return length = 0.", (){
      expect( empty["unknown"].length, equals(0) );
    });

    test( "Adding 20 sprites manually in the spritepack should result in a .length = 20.", (){
      expect( chicoNormal.length, equals(20) );
    });

    test( "Loading an existing spritepack with .fromTileSheet must load 20 sprites.", (){
      expect( chicoTile.length, equals(20) );
    });

    test( "Loading an existing spritepack with .fromJSON must load 20 sprites.", (){
      expect( chicoJSON.length, equals(20) );
    });

    test( "Every manually added Sprite must be equal to a individual loaded sprite.", (){
      List<Future<dynamic>> futures  = new List<Future<dynamic>>();
      List<Sprite> sprs = new List<Sprite>();
      for( int i = 1; i < 21; ++ i )
      {
        Sprite spr = new Sprite(imageSource:"resources/chico/chico_$i.png", offset: new Point2D.zero());
        futures.add( spr.onLoad );
        sprs.add( spr );
      }
      Future.wait(futures).then( expectAsync1( (_){
        for( int i = 0; i < 20; ++i )
        {
          expect( chicoNormal[""][i], equals(sprs[i]) );
        }
      }));
    });

    test( "Every added Sprite trought the .fromTileSheet must be equal to the individual loaded sprites.", (){
      List<Future<dynamic>> futures  = new List<Future<dynamic>>();
      List<Sprite> sprs = new List<Sprite>();
      for( int i = 1; i < 21; ++ i )
      {
        Sprite spr = new Sprite(imageSource:"resources/chico/chico_$i.png", offset: new Point2D.zero());
        futures.add( spr.onLoad );
        sprs.add( spr );
      }
      Future.wait(futures).then( expectAsync1( (_){
        for( int i = 0; i < 20; ++i )
        {
          expect( chicoTile["0"][i], equals(sprs[i]) );
        }
      }));
    });

    test( "Every added Sprite trought the .fromJSON must be equal to the individual loaded sprites.", (){
      List<Future<dynamic>> futures  = new List<Future<dynamic>>();
      List<Sprite> sprs = new List<Sprite>();
      for( int i = 1; i < 21; ++ i )
      {
        Sprite spr = new Sprite(imageSource:"resources/chico/chico_$i.png", offset: new Point2D.zero());
        futures.add( spr.onLoad );
        sprs.add( spr );
      }
      Future.wait(futures).then( expectAsync1( (_){
        for( int i = 0; i < 20; ++i )
        {
          expect( chicoJSON["group"][i], equals(sprs[i]) );
        }
      }));
    });


  });
}