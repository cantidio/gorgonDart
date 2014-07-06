/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library font_alignment_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  group("FontAlignment",(){

    test( ".left value is 0", (){
      expect( FontAlignment.left.value, equals( 0 ) );
    });

    test( ".left name is 'left'", (){
      expect( FontAlignment.left.name, equals( "left" ) );
    });

    test( ".center value is 1", (){
      expect( FontAlignment.center.value, equals( 1 ) );
    });

    test( ".center name is 'center'", (){
      expect( FontAlignment.center.name, equals( "center" ) );
    });

    test( ".right value is 2", (){
      expect( FontAlignment.right.value, equals( 2 ) );
    });

    test( ".right name is 'right'", (){
      expect( FontAlignment.right.name, equals( "right" ) );
    });

    /*test( "Object can not be created with new",(){
      expect( () => new FontAlignment(), throws );
    } );*/

  });
}