/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
part of gorgon;
/**
 * A basic Sprite Element which is composed of an ImageElement and an offset.
 */
class Sprite
{
  static final ImageElement emptyImage = new ImageElement();  /// Object that represents an emptyImage
  ImageElement _image;    /// The sprite element.
  int _width;             /// The sprite initial width.
  int _height;            /// The sprite initial height.
  Point offset;           /// The sprite offset.
  Future<Sprite> _onLoad; /// The sprite onLoad future.

  Future<Sprite> get onLoad => _onLoad; /// The Sprite onLoad future getter.
  int get width   => _width;            /// The Sprite width getter.
  int get height  => _height;           /// The Sprite height getter.
  ImageElement get image => _image;     /// The Sprite image getter.

  /**
   * Method that describes the Sprite Object returning a [String].
   */
  String toString() => "Sprite(width: $width, height: $height, offset: ${offset.toString()})";
  /**
   * Private Method that sets the content of the internal [image] which must be an [ImageElement].
   *
   * This method checks if the provided image is null or not.
   * If it is null then it will attribute the internal [_image] to the [Sprite.emptyImage].
   */
  void _setImage( ImageElement image )
  {
    if( image != null )
    {
      this._image   = image;
      this._width   = image.width;
      this._height  = image.height;
    }
    else
    {
      this._setImage( Sprite.emptyImage );
    }
  }

  /**
   * Create a new Sprite.
   *
   * You can provide an [imageSource] which must be a [String] with the image source
   * or the base64 image source.
   *
   * You can provide the [offset] which is a xy [Point] with the offset of the sprite.
   * If none is provided the default [offset] value is [Point.zero].
   *
   * If an [imageSource] is provided it is possible to check for the load completion by accessing the
   * [onLoad] [Future] getter.
   */
  Sprite({ String imageSource, Point offset })
  {
    this._onLoad  = new Completer().future;
    this.offset   = ( offset != null ) ? offset : new Point.zero();
    if( imageSource != null && imageSource != "" )
    {
      this.load( imageSource );
    }
    else
    {
      this._setImage( null );
    }
  }
  /**
   * Creates a new Sprite with a previously loaded [ImageElement].
   *
   * You must provide a image which must be an [ImageElement]. This Image will be the image used by the sprite.
   * The sprite will not deal with the load method in this case.
   *
   * You can provide the [offset] which is a xy [Point] with the offset of the sprite.
   * If none is provided the default [offset] value is [Point.zero].
   */
  Sprite.fromImage( ImageElement image, { Point offset } )
  {
    this._onLoad  = new Completer().future;
    this.offset   = ( offset != null ) ? offset : new Point.zero();
    this._setImage( image );
  }
  /**
   * Loads the sprite with the image given [imageSrc], which must be an [String]
   * containing the url of the image or the base64 image source.
   *
   * For checking when the load is complete you can access the [Future] [onLoad]
   *
   * This method returns a [Sprite] object referencing this current object.
   */
  Future<Sprite> load( String imageSrc )
  {
    Completer completer = new Completer();
    ImageElement   img  = new ImageElement();

    img.onLoad.listen((e)
    {
      this._setImage( img );
      completer.complete( this );
    });

    img.src       = imageSrc;
    this._onLoad  = completer.future;

    return this._onLoad;
  }
  
  void rotate( double angle )
  {
    
  }
  void flip( Mirroring mirroring )
  {
    
  }
}
