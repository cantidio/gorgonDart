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
  test( "SpritePack Empty length is 0", (){
    SpritePack empty = new SpritePack();

    expect( empty.length    , equals( 0 ) );
  });
  
  test( "SpritePack Empty access sprite at [0] throws RangeError.", (){
    SpritePack empty = new SpritePack();

    expect( () => empty[0], throwsRangeError );
  });
  
  test( "SpritePack Empty access sprite at [10] throws RangeError.", (){
    SpritePack empty = new SpritePack();

    expect( () => empty[10], throwsRangeError );
  });
}