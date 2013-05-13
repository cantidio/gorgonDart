/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
library sprite_test;

import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  test
  (
      "Sprite Empty", (){
        Sprite empty = new Sprite();

        expect( empty.width, equals( 0 ) );
        expect( empty.height, equals( 0 ) );
        expect( empty.image, equals( Sprite.emptyImage ) );
        expect( empty.offset.x, equals( 0 ) );
        expect( empty.offset.y, equals( 0 ) );
  });
}