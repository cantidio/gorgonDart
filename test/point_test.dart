library sprite_test;

import "package:unittest/unittest.dart";
import '../src/gorgon.dart';

void main()
{
  test
  (
      "Point.zero", (){
        Point zero = new Point.zero();
        
        expect( zero.x, equals( 0.0 ) );
        expect( zero.y, equals( 0.0 ) );
  });
        
}