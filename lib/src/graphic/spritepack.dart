/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;

class SpritePack
{
  /// Object that represents an empty Sprite.
  static final Sprite emptySprite = new Sprite();
  List<Sprite>    _sprites        = new List<Sprite>();     // The Sprite list
  Future<Sprite>  _onLoad         = new Completer().future; // The spritepack onLoad future.

  /// The SpritePack onLoad future getter.
  Future<Sprite> get onLoad => _onLoad;

  /// The SpritePack length getter
  int get length   => _sprites.length;

  /**
   * Method that describes the Sprite Object returning a [String].
   */
  String toString() => "SpritePack(length: $length)";

  SpritePack([fileUrl])
  {
    if( fileUrl != null )
    {

    }
  }

  SpritePack.fromLua(){}
  /**
   * Method that creates a [SpritePack] from a json provided its[jsonUrl] as a [String].
   *
   * You can check the completion of this method with the getter [onLoad]
   */
  SpritePack.fromJSON( String jsonUrl)
  {
    Completer completer = new Completer();
    List<Future<Sprite>> spr_futures = new List<Future<Sprite>>();

    HttpRequest.getString(jsonUrl).then((response) {
      dynamic obj = json.parse(response);
      if( obj["spritepack"] != null )
      {
        for( dynamic spr in obj["spritepack"] )
        {
          Sprite sprite = new Sprite();
          sprite.offset.x = spr["xoffset"];
          sprite.offset.y = spr["yoffset"];
          spr_futures.add( sprite.load( spr["image"] ));
          this.add( sprite );
        }
      }
      Future.wait(spr_futures)
        .then((_) => completer.complete(this))
        .catchError((e){ completer.completeError(e); });
    });

    _onLoad = completer.future;
  }
  SpritePack.fromXML(){}
  SpritePack.fromTileSheet(){}

  /**
   * Method that adds a new [Sprite] into the [SpritePack].
   */
  void add(Sprite sprite) => _sprites.add(sprite);

  /**
   * Operator that retrieves the requested [i] [Sprite]  in the [SpritePack].
   *
   * @todo decide if when trying to get an inexistent sprite it should return an exception or an emptySprite.
   */
  operator [](int i) => _sprites[i];
}
