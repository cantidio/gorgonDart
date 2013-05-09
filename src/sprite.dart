part of gorgon;

/**
 * A basic Sprite Element which is composed by and ImageElement and an offset.
 */
class Sprite
{
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
    this.offset = offset != null ? offset : new Point.zero();
    if( imageSource != null && imageSource != "" )
    {
      this.load( imageSource );
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
    if( image != null && image.src != "" )
    {
      this._width   = image.width;
      this._height  = image.height;
    }
    this.offset = offset != null ? offset : new Point.zero();
  }
  /**
   * Loads the sprite with the image given [imageSrc], which must be an [String]
   * containing the url of the image or the base64 image source.
   * 
   * For checking when the load is complete you can access the [Future] [onLoad]
   * 
   * This method returns a [Sprite] object referencing this current object.
   */
  Sprite load( String imageSrc )
  {
    Completer completer = new Completer();
    Element   img       = new ImageElement();
    
    img.onLoad.listen((e) 
    {
        this._image   = img;
        this._width   = img.width;
        this._height  = img.height;
        
        completer.complete(this); 
    });

    img.src = imageSrc;
    _onLoad = completer.future;

    return this;
  }
}
