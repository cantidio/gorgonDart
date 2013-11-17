/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents an [Animation] package.
 */
class Animationpack
{
  HashMap<String, Animation> _animations = new HashMap<String, Animation>(); // The group map
  Future<Animationpack>  _onLoad = new Completer().future; // The spritepack onLoad future.

  /// The [Animationpack] onLoad future getter.
  Future<Animationpack> get onLoad => _onLoad;

  /// The number of [Animation]s inside the [Animationpack].
  int get length => _animations.length;

  /// Returns a [List] of the available [Animation]s in the [Spritepack].
  List<String> get animations => _animations.keys.toList(growable: false);

  /**
   * Method that describes the Animationpack Object returning a [String].
   */
  String toString() => "Animationpack(animations: $_animations)";

  void _loadFromMap( Map animationpack, Completer completer )
  {
    animationpack.forEach((name,animation){
      add( new Animation.fromMap(animation), name );
    });
    completer.complete(this);
  }

  /**
   * Creates an empty [Animationpack] Object.
   */
  Animationpack();

  /**
   * Creates an [Animationpack] based in a [animationpack] [Map].
   *
   * The [Map] [animationpack] must be like this:
   * [Map] [animationpack] = {
   *    "animation_name" :{
   *      "looping":      true,
   *      "loopFrame":    0,
   *      "repeatNumber": -1,
   *      "time":         6,
   *      "frames": [
   *        { "group": "sprite_group", "index": 0, "xoffset": 0, "yoffset":0, "time": 5, "mirroring": "None", "rotation": 0 },
   *        { "group": "sprite_group", "index": 1, "xoffset": 0, "yoffset":0, "mirroring": "H"},
   *        { "group": "sprite_group", "index": 2,  "time": 5, "mirroring": "V", "rotation": 0 },
   *        { "group": "sprite_group", "index": 3, "mirroring": "HV" },
   *      ]
   *    },
   *    "other_animation": {
   *      ...
   *      ...
   *    }
   * };
   */
  Animationpack.fromMap( Map animationpack )
  {
    Completer completer = new Completer();
    _loadFromMap(animationpack,completer);
    _onLoad = completer.future;
  }

  /**
   * Creates an [Animationpack] from a JSON provided it's [jsonUrl] as a [String].
   *
   * You can check the completion of this method with the getter [onLoad]
   */
  Animationpack.fromJSON( String jsonUrl )
  {
    Completer completer = new Completer();
    HttpRequest.getString(jsonUrl).then((response) {
      Map pack = JSON.decode(response);

      if( pack["animationpack"] != null )
      {
        _loadFromMap(pack["animationpack"], completer);
      }
      else
      {
        completer.completeError(new Exception("animationpack not found"));
      }
    });
    _onLoad = completer.future;
  }

  /**
   * Method that adds a [Animation] into the [Animationpack]
   *
   * You must assign a [name] which will be the way to retrieve the [animation].
   *
   * This method returns the reference to the added [Animation].
   */
  Animation add( Animation animation, var name )
  {
    name = name.toString();
    if( _animations[name] != null )
    {
      throw new Exception("The animationpack already has an animation named: '{$name}'");
    }
    _animations[name] = animation;
    return animation;
  }

  /**
   * Method that removes an [Animation] from the [Animationpack].
   *
   * You must pass the [key] of the [Animation] you want to remove.
   *
   * The [Animation] removed from the [Animationpack] is returned.
   */
  Animation remove( var key )
  {
    return _animations.remove( key.toString() );
  }

  /**
   * Operator that returns a [Animation] of the requested [name].
   */
  Animation operator []( var name )
  {
    return _animations[ name.toString() ];
  }

  /**
   * Applies the function [f] to each [Animation] {name, [Animation]} of the [Spritepack].
   */
  void forEach(void f( String name, Animation animation ) )
  {
    _animations.forEach(f);
  }


}
