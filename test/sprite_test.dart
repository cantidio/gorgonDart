library sprite_test;

import "package:unittest/unittest.dart";
import '../src/gorgon.dart';

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