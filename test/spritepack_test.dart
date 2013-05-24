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
    SpritePack empty;
    SpritePack chicoNormal;
    SpritePack chicoTile;

    setUp((){
      Completer completer = new Completer();
      List<Future<dynamic>> futures  = new List<Future<dynamic>>();

      empty       = new SpritePack();
      chicoNormal = new SpritePack();
      for( int i = 1; i < 21; ++ i )
      {
        Sprite spr = new Sprite(imageSource:"resources/chico/chico_$i.png", offset: new Point2D.zero());
        futures.add( spr.onLoad );
        chicoNormal.add( spr );
      }
      chicoTile = new SpritePack.fromTileSheet("resources/chico/chico.png", 79, 79, new Point2D.zero());
      futures.add(chicoTile.onLoad);

      Future.wait(futures).then((_) => completer.complete()).catchError((e){ completer.completeError(e); });

      return completer.future;
    });

    test( "Empty length is 0", (){
      expect( empty.length    , equals( 0 ) );
    });

    test( "Empty accessing sprite at [0] throws RangeError.", (){
      expect( () => empty[0], throwsRangeError );
    });

    test( "Adding 20 sprites manually in the spritepack should result in a .length = 20.", (){
      expect( chicoNormal.length, equals(20) );
    });

    test( "Loading an existing spritepack with .fromTileSheet must load 20 sprites.", (){
      expect( chicoTile.length, equals(20) );
    });

  });

}