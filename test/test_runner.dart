/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';

import 'point_test.dart'      as point_test;
import 'mirroring_test.dart'  as mirroring_test;
import 'color_test.dart'      as color_test;
import 'sprite_test.dart'     as sprite_test;
import 'spritepack_test.dart' as spritepack_test;

main()
{
  point_test.main();
  mirroring_test.main();
  color_test.main();
  sprite_test.main();
  spritepack_test.main();

  dynamic obj = [
    { "name" : "logo"   , "group" : 100, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "resources/logo.png"     },
    { "name" : "logo"   , "group" : 100, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "resources/logo_fh.png"  },
    { "name" : "logofh" , "group" : 100, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "resources/logo_fv.png"  },
    { "name" : "logofv" , "group" : 100, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "resources/logo_fhv.png" }
   ];
  /*SpritePack ssp = new SpritePack.fromOBJ(obj);
  //SpritePack ssp = new SpritePack.fromJSON("resources/spritepack.json");
  ssp.onLoad
    .then((_) {
      print( "length: ${ssp.length}" );
        for( int i = 0; i < ssp.length+1; ++i )
        {
          try
          {
            query("#content").append( ssp[i].image );
          }
          catch( e )
          {
            print("exception: "+ e.toString());
          }
        }
    } )
    .catchError((e){
      print("got error: {$e.error}");
    });
  Sprite logo = new Sprite( imageSource: "resources/logo2.png");
  logo.onLoad
    .then((_) => logo.flipV())
    .then((_) => logo.flipH())
    .then((_) => logo.rotateRight())
    .then((_) => logo.rotateRight())
    .then((_) { query("#content").append(logo.image);} )
    .catchError((e){
      print("got error: {$e.error}");
    });*/
}
