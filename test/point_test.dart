library point_test;

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

  test
  (
      "Point 10, 5", (){
        Point zero = new Point(10.0,5.0);

        expect( zero.x, equals( 10.0 ) );
        expect( zero.y, equals( 5.0 ) );
  });

  test
  (
      "Point 5, 10", (){
        Point zero = new Point(5.0,10.0);

        expect( zero.x, equals( 5.0 ) );
        expect( zero.y, equals( 10.0 ) );
  });

}