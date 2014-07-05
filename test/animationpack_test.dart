/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library animationpack_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  group("Animationpack",(){
    Animationpack empty;
    Animationpack normal;
    Animationpack mapped_empty;
    Animationpack mapped_normal;
    Animationpack json;

    setUp((){
      empty         = new Animationpack();
      mapped_empty  = new Animationpack.fromMap({});
      mapped_normal = new Animationpack.fromMap
      ({
        "walk": {
          "looping":      true,
          "loopFrame":    0,
          "repeatNumber": -1,
          "time":         6,
          "frames": [
             { "group": "walk", "index": 0 },
             { "group": "walk", "index": 1 },
             { "group": "walk", "index": 2 },
             { "group": "walk", "index": 3 },
             { "group": "walk", "index": 4 },
             { "group": "walk", "index": 3 },
             { "group": "walk", "index": 2 },
             { "group": "walk", "index": 1 }
           ]
        }
      });
      json = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");
      return json.onLoad;
    });

    test("When using the Empty Constructor the  Animationpack.length is 0",(){
      expect( empty.length, equals(0));
    });

    test("When using the Empty Constructor the  Animationpack.animations is new List<String>()",(){
      expect( empty.animations, equals(new List<String>()));
    });

    test("When using the Empty Constructor the  Animationpack.toString() is new 'Animationpack(animations: {})'",(){
      expect( empty.toString(), equals("Animationpack(animations: {})"));
    });

    test("When using the Constructor .fromMap with an empty Map, the  Animationpack.length is 0",(){
      expect( mapped_empty.length, equals(0));
    });

    test("When using the Constructor .fromMap with an empty Map, the  Animationpack.animations is new List<String>()",(){
      expect( mapped_empty.animations, equals(new List<String>()));
    });

    test("When using the Constructor .fromMap with an empty Map, the  Animationpack.toString() is new 'Animationpack(animations: {})'",(){
      expect( mapped_empty.toString(), equals("Animationpack(animations: {})"));
    });

    test("Using the operator Animationpack[] accessing inexistent animations returns null.",(){
      expect( empty[''], equals(null) );
    });

    test("When Using the add method in an empty animationpack the animationpack.length must increase by 1.",(){
      int before = empty.length;
      empty.add( new Animation(), "anim" );
      expect(empty.length, equals(before + 1));
    });

    test("When Using the add method in an empty animationpack the added animation is returned.",(){
      Animation animation = new Animation();
      expect( empty.add(animation, "anim"), equals(animation));
    });

    test("When Using the add method in an empty animationpack the animation['key'] must contain the added animation.",(){
      Animation animation = empty.add(new Animation(),"anim");
      expect( empty["anim"], equals(animation));
    });

    test("When Using the add method to insert an animation with a name that is already added in the animationpack, throws an exception.",(){
      empty.add( new Animation(), "anim" );
      expect(() => empty.add(new Animation(),"anim") , throws );
    });

    test("After Using the remove method in an animationpack, the animationpack.length must decrease by 1.",(){
      int before = mapped_normal.length;
      mapped_normal.remove( mapped_normal.animations[0] );
      expect( mapped_normal.length, equals(before-1) );
    });

    test("After Using the remove method in an animationpack, only the requested animation must be removed.",(){
      Animation removed = mapped_normal[ mapped_normal.animations[0] ];
      mapped_normal.remove( mapped_normal.animations[0] );
      mapped_normal.forEach((key, anim){
        expect(removed, isNot(equals(anim)));
      });
    });

    test("Using the forEach must call the desired function for each Animation in the Animationpack.",(){
      var keys = ["walk","stand"];
      var anims = [json["walk"], json["stand"]];
      json.forEach( (k,v){
        expect(k, equals(keys.removeLast()));
        expect(v, equals(anims.removeLast()));
        });
      expect(keys.length, equals(0));
    });





  });
}