/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a package of sprites.
 */
class SpritePack
{
  /// Object that represents an empty Sprite.
  static final Sprite emptySprite = new Sprite();
  List<Sprite>        _sprites    = new List<Sprite>();     // The Sprite list
  Future<SpritePack>  _onLoad     = new Completer().future; // The spritepack onLoad future.

  /// The SpritePack onLoad future getter.
  Future<SpritePack> get onLoad => _onLoad;

  /// The SpritePack length getter
  int get length   => _sprites.length;
  
  /**
   * Method that describes the Sprite Object returning a [String].
   */
  String toString() => "SpritePack(length: $length)";

  /**
   * Method that loads an [SpritePack] based in a [spritepack] object.
   * 
   * **Warning** This method will always consider the image path given as a full path or relative to the invoker.
   * 
   * The [dynamic] [spritepack] must be like this:
   * dynamic [spritepack] = [
   *   { "name" : "name" , "group" : 0, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image1.png" },
   *   { "name" : "name" , "group" : 1, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image2.png" },
   *   { "name" : "name" , "group" : 1, "index" : 1, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image3.png" },
   *   { "name" : "name" , "group" : 2, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image4.png" }
   * ];
   */
  void _loadFromObj( dynamic spritepack, Completer completer )
  {
    List<Future<Sprite>> spr_futures  = new List<Future<Sprite>>();
    for( dynamic spr in spritepack )
    {
      Sprite sprite = new Sprite();
      sprite.offset.x = spr["xoffset"];
      sprite.offset.y = spr["yoffset"];
      spr_futures.add( sprite.load( spr["image"] ) );
      this.add( sprite );
    }
    Future.wait(spr_futures)
      .then((_) => completer.complete(this))
      .catchError((e){ completer.completeError(e); });
  }
  /**
   * Method that creates an empty [SpritePack].
   */
  SpritePack();
  /**
   * Method that creates an [SpritePack] based in a [spritepack] object.
   * 
   * **Warning** This method will always consider the image path given as a full path or relative to the invoker.
   * 
   * You can check the completion of this method with the getter [onLoad].
   * 
   * The [dynamic] [spritepack] must be like this:
   * dynamic [spritepack] = [
   *   { "name" : "name" , "group" : 0, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image1.png" },
   *   { "name" : "name" , "group" : 1, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image2.png" },
   *   { "name" : "name" , "group" : 1, "index" : 1, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image3.png" },
   *   { "name" : "name" , "group" : 2, "index" : 0, "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image4.png" }
   * ];
   */
  SpritePack.fromOBJ( dynamic spritepack )
  {
    Completer completer = new Completer();
    _loadFromObj( spritepack, completer );
    _onLoad = completer.future; 
  }
  /**
   * Method that creates a [SpritePack] from a json provided its[jsonUrl] as a [String].
   *
   * **Warning** This method will check if the image paths provided in the JSON are base64 data or an full URL, if not
   * then it will load the image files from the same place/folder the JSON file was loaded.
   * 
   * You can check the completion of this method with the getter [onLoad]
   */
  SpritePack.fromJSON( String jsonUrl )
  {
    String baseUrl                    = jsonUrl.substring( 0, jsonUrl.lastIndexOf("/") + 1 );
    Completer completer               = new Completer();
    List<Future<Sprite>> spr_futures  = new List<Future<Sprite>>();
    
    HttpRequest.getString(jsonUrl).then((response) {
      dynamic obj = JSON.parse(response);
      if( obj["spritepack"] != null )
      {
        obj["spritepack"].forEach((spr){ 
          if( !spr["image"].contains("data:image/") )
          {
            if( new Uri(spr["image"]).domain == "" )
            {
              spr["image"] = baseUrl + spr["image"];
            }
          }
        });        
        _loadFromObj( obj["spritepack"], completer );
      }
    });

    _onLoad = completer.future;
  }
  /**
   * @todo implement this method.
   */
  SpritePack.fromTileSheet(){
    throw new Exception("Method not implemented.");
  }

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
