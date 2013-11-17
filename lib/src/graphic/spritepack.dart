/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a package of sprites.
 */
class Spritepack
{
  Map<String, List<Sprite>> _groups = new Map<String, List<Sprite>>(); // The group map
  Future<Spritepack>  _onLoad = new Completer().future; // The spritepack onLoad future.

  /// Object that represents an empty Sprite.
  static final Sprite emptySprite = new Sprite();

  /// The [Spritepack] onLoad future getter.
  Future<Spritepack> get onLoad => _onLoad;

  /// Returns a [List] of the available [groups] in the [Spritepack]
  List<String> get groups => _groups.keys.toList(growable: false);

  /// Returns the number of [Sprite]s in the [Spritepack]
  int get length {
    int num = 0;
    forEachGroup((K,V){ num += V.length; });
    return num;
  }

  /**
   * Method that describes the Spritepack Object returning a [String].
   */
  String toString() => "Spritepack(groups: $groups)";

  /**
   * Method that creates an empty [Spritepack].
   */
  Spritepack();

  /**
   * Method that loads an [Spritepack] based in a [spritepack] object.
   *
   * **Warning** This method will always consider the image path given as a full path or relative to the invoker.
   *
   * The [Map] [spritepack] must be like this:
   * [Map] [spritepack] = {
   *    "group1" :[
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image1.png" },
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image2.png" },
   *    ],
   *    "group2" :[
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image3.png" },
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image4.png" }
   *    ]
   * };
   */
  void _loadFromMap( Map spritepack, Completer completer )
  {
    List<Future<Sprite>> spr_futures  = new List<Future<Sprite>>();

    spritepack.forEach((group, list) {
      list.forEach((spr) {
        Sprite sprite   = new Sprite();
        sprite.offset.x = spr["xoffset"];
        sprite.offset.y = spr["yoffset"];
        sprite.load(spr["image"]);

        spr_futures.add( this.add( sprite, group: group ).onLoad );
      });
    });
    Future.wait(spr_futures)
      .then((_) => completer.complete(this))
      .catchError((e){ completer.completeError(e); });
  }
  /**
   * Method that creates an [Spritepack] based in a [spritepack] object.
   *
   * **Warning** This method will always consider the image path given as a full path or relative to the invoker.
   *
   * You can check the completion of this method with the getter [onLoad].
   *
   * The [Map] [spritepack] must be like this:
   * [Map] [spritepack] = {
   *    "group1" :[
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image1.png" },
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image2.png" },
   *    ],
   *    "group2" :[
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image3.png" },
   *        { "xoffset" : 0, "yoffset" : 0, "image" : "fullpath/image4.png" }
   *    ]
   * };
   */
  Spritepack.fromMap( Map spritepack )
  {
    Completer completer = new Completer();
    _loadFromMap( spritepack, completer );
    _onLoad = completer.future;
  }
  /**
   * Method that creates a [Spritepack] from a json provided its[jsonUrl] as a [String].
   *
   * **Warning** This method will check if the image paths provided in the JSON are base64 data or an full URL, if not
   * then it will load the image files from the same place/folder the JSON file was loaded.
   *
   * You can check the completion of this method with the getter [onLoad]
   */
  Spritepack.fromJSON( String jsonUrl )
  {
    String baseUrl                    = jsonUrl.substring( 0, jsonUrl.lastIndexOf("/") + 1 );
    Completer completer               = new Completer();
    List<Future<Sprite>> spr_futures  = new List<Future<Sprite>>();

    HttpRequest.getString(jsonUrl).then((response) {
      dynamic obj = JSON.decode(response);
      if( obj["spritepack"] != null )
      {
        obj["spritepack"].forEach((group, list){
          list.forEach((spr){
            if( !spr["image"].contains("data:image/") )
            {
              if( Uri.parse(spr["image"]).host == "" )
              {
                spr["image"] = baseUrl + spr["image"];
              }
            }
          });
        });
        _loadFromMap( obj["spritepack"], completer );
      }
    });

    _onLoad = completer.future;
  }
  /**
   * Method that creates a [Spritepack] from a tilesheet image.
   *
   * This method will take an image in the [tileUrl] provided and separate it in a lot of other images.
   *
   * All of the images created will be of the [tileWidth] width and [tileHeight] height.
   * You can define a [offset] for the sprites, but if none provided than the default offset will be
   * [new Point2D]([tileWidth]/2, [tileHeight]/2).
   *
   * The [Sprite]s group will be set per line in the spritesheet. The index per collumn.
   *
   * You can check the completion of this method with the getter [onLoad]
   */
  Spritepack.fromTileSheet( String tileUrl, int tileWidth, int tileHeight, [Point2D offset] )
  {
    Completer completer = new Completer();
    ImageElement   img  = new ImageElement();
    List<Future<Sprite>> spr_futures  = new List<Future<Sprite>>();

    offset = ( offset != null ) ? offset : new Point2D( (tileWidth/2).ceil(), (tileHeight/2).ceil() );
    img.onLoad.listen((e)
    {
      CanvasElement canvas = new CanvasElement( width: tileWidth, height: tileHeight );
      Map spritepack = new Map();
      int tilesX = (img.width/tileWidth).ceil();
      int tilesY = (img.height/tileHeight).ceil();

      for( int i = 0; i < tilesY; ++i )
      {
        spritepack["$i"] = new List<Object>();
        for( int j = 0; j < tilesX; ++j )
        {
          canvas.context2D.clearRect( 0, 0, canvas.width, canvas.height );
          canvas.context2D.drawImage( img, -j*tileWidth, -i*tileHeight );
          spritepack["$i"].add({
            "xoffset":  offset.x,
            "yoffset":  offset.y,
            "image":    canvas.toDataUrl('image/png')
          });
        }
      }
      _loadFromMap( spritepack, completer );
    });

    img.onError.listen((e)
    {
      completer.completeError(new Exception("TileSheet: $tileUrl could not be found."));
    });

    img.src = tileUrl;
    _onLoad = completer.future;
  }

  /**
   * Method that adds a [Sprite] into the [Spritepack]
   *
   * You can tell assign a [group] to place the [Sprite] if none is assigned then it places the [Sprite] in a group [""].
   *
   * If you pass a [index], then the [Sprite] will be added in the assigned [group] in the requested [index].
   *
   * This method returns the reference to the added [Sprite].
   */
  Sprite add(Sprite sprite, { var group: "", int index })
  {
    group = group.toString();
    if( index != null )
    {
      this[group].insert(index, sprite);
    }
    else
    {
      this[group].add(sprite);
    }
    return sprite;
  }

  /**
   * Method that removes a [Sprite] in a [group] from the [Spritepack].
   *
   * This method returns the removed [Sprite].
   */
  Sprite removeSprite( String group, Sprite sprite )
  {
    this[group].remove( sprite );
    return sprite;
  }

  /**
   * Method that removes an entire group of [Sprites] from the [Spritepack].
   *
   * This method returns the [Sprite] [List].
   */
  List<Sprite> removeGroup( var groupName )
  {
    return _groups.remove( groupName.toString() );
  }

  /**
   * Operator that returns a [Sprite] [List] of the requested [group].
   *
   * If the requested [group] do not exist, then an empty [List] will be created and assigned to that [group].
   */
  List<Sprite> operator []( var group )
  {
    group = group.toString();
    if( _groups[group] == null )
    {
      _groups[group] = new List<Sprite>();
    }
    return _groups[group];
  }

  /**
   * Applies the function [f] to each group {group, spriteList} of the [Spritepack].
   */
  void forEachGroup(void f( String group, List<Sprite> spriteList ) )
  {
    _groups.forEach(f);
  }

  /**
   * Applies the function [f] to each sprite of all groups in the [Spritepack].
   */
  void forEachSprite(void f( Sprite sprite ) )
  {
    forEachGroup((g,l){
      l.forEach(f);
    });
  }
}
