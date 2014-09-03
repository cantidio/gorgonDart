/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * A basic Sprite Element which is composed of an ImageElement and an offset.
 */
class Sprite
{
  ImageElement    _image;                           // The sprite element.
  Future<Sprite>  _onLoad = new Completer().future; // The sprite onLoad future.
  int             _width;                           // The sprite initial width.
  int             _height;                          // The sprite initial height.
  Rectangle       _bounds;                          // The boundaries of the sprite

  /// Object that represents an emptyImage
  static final ImageElement emptyImage = new ImageElement();

  /// The sprite offset.
  Point2D offset;

  /// The Sprite onLoad future getter.
  Future<Sprite> get onLoad => _onLoad;

  /// The Sprite width getter.
  int get width   => _bounds.width;

  /// The Sprite height getter.
  int get height  => _bounds.height;

  /// The Sprite image getter.
  ImageElement get image => _image;

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
  void _setImage( ImageElement image, [Rectangle bounds=null] )
  {
    if( image != null )
    {
      this._image   = image;
      this._bounds = (bounds!=null) ? bounds : new Rectangle(0,0,image.width,image.height);
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
   * You can provide the [offset] which is a xy [Point2D] with the offset of the sprite.
   * If none is provided the default [offset] value is [Point2D.zero].
   *
   * If an [imageSource] is provided it is possible to check for the load completion by accessing the
   * [onLoad] [Future] getter.
   */
  Sprite({ String imageSource, Point2D offset })
  {
    this.offset   = ( offset != null ) ? offset : new Point2D.zero();
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
   * You can provide the [offset] which is a xy [Point2D] with the offset of the sprite.
   * If none is provided the default [offset] value is [Point2D.zero].
   */
  Sprite.fromImage( ImageElement image, { Point2D offset } )
  {
    this.offset   = ( offset != null ) ? offset : new Point2D.zero();
    this._setImage( image );
  }

  Future<Sprite> loadImageData(ImageElement data, Rectangle src){
    Completer completer = new Completer();
    _setImage(data,src);
    this._onLoad  = completer.future;
    completer.complete( this );
    return this._onLoad;
  }
  /**
   * Loads the sprite with the image given [imageSource], which must be an [String]
   * containing the url of the image or the base64 image source.
   *
   * For checking when the load is complete you can access the [Future] [onLoad]
   *
   * This method returns a [Sprite] object referencing this current object.
   */
  Future<Sprite> load( String imageSource )
  {
    Completer completer = new Completer();
    ImageElement   img  = new ImageElement();

    img.onLoad.listen((e)
    {
      this._setImage( img );
      completer.complete( this );
    });

    img.onError.listen((e)
    {
      completer.completeError(new Exception("Image: $imageSource could not be found."));
    });

    img.src       = imageSource;
    this._onLoad  = completer.future;

    return this._onLoad;
  }
  /**
   * Method that rotates the [Sprite] 90 degrees to the right.
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> rotateRight()
  {
    CanvasElement canvas = new CanvasElement(width: height, height: width);
    canvas.context2D.translate( height, 0 );
    canvas.context2D.rotate( 90 * PI / 180 );
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);


    num    y = offset.y;
    offset.y = offset.x;
    offset.x = -(height + y);

    return this.load( canvas.toDataUrl('image/png') );
  }
  /**
   * Method that rotates the [Sprite] to the left.
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> rotateLeft()
  {
    CanvasElement canvas = new CanvasElement(width: height, height: width);
    canvas.context2D.translate( 0, width );
    canvas.context2D.rotate( -90 * PI / 180 );
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);

    num x    = offset.x;
    offset.x = offset.y;
    offset.y = -(width + x);

    return this.load( canvas.toDataUrl('image/png') );
  }
  /**
   * Method that flips the current [Sprite] horizontally
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> flipH()
  {
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    canvas.context2D.translate(width, 0);
    canvas.context2D.scale(-1, 1);
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);

    offset.x = -(width + offset.x);

    return this.load( canvas.toDataUrl('image/png') );
  }
  /**
   * Method that flips the current [Sprite] vertically
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> flipV()
  {
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    canvas.context2D.translate(0, height);
    canvas.context2D.scale(1, -1);
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);

    offset.y = -(height + offset.y);

    return this.load( canvas.toDataUrl('image/png') );
  }
  /**
   * Method that flips the current [Sprite] horizontally and vertically
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> flipHV()
  {
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    canvas.context2D.translate(width, height);
    canvas.context2D.scale(-1, -1);
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);

    offset.x = -(width + offset.x);
    offset.y = -(height + offset.y);

    return this.load( canvas.toDataUrl('image/png') );
  }
  /**
   * Method that flips the [Sprite] using the provided [Mirroring].
   *
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> flip( Mirroring mirroring )
  {
    switch( mirroring )
    {
      case Mirroring.H:   return flipH();
      case Mirroring.V:   return flipV();
      case Mirroring.HV:  return flipHV();
      default: throw new ArgumentError("Mirroring: '#{mirroring}' unknown.");
    }
  }
  /**
   * Method that returns the [ImageData] of the [Sprite] by it's current bounds.
   */
  ImageData getImageData(){
    CanvasElement canvas = new CanvasElement( width: width, height: height );
    canvas.context2D.drawImageToRect( _image, new Rectangle(0,0,width,height),sourceRect: _bounds);
    return canvas.context2D.getImageData(0, 0, width, height);
  }
  /**
   * Operator that checks if the content of 2 [Sprite]s are the same.
   *
   * **Warning** This operator will check every image pixel.
   */
  operator == (Sprite other)
  {
    if( width == other.width && height == other.height && offset == other.offset)
    {
      ImageData data1 = getImageData();
      ImageData data2 = other.getImageData();
      if( data1.data.length == data2.data.length )
      {
        for(int i=0; i < data1.data.length; ++i)
        {
          if(data1.data[i] != data2.data[i])
          {
            return false;
          }
        }
        return true;
      }
    }
    return false;
  }

  void trim()
  {
    throw new UnimplementedError("This method is not implemmented.");
  }

  /**
   * Method that draws the [Sprite] in the current [Display.target].
   *
   * This method will draws the [Sprite] in the [position] provided of [Display] using the [Display.draw] method.
   *
   * You can provide the desired [alpha], [mirroring], [rotation] and [scale] if needed.
   */
  void draw( Point2D position, { double alpha: 1.0, Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1 } )
  {
    if( Display.target != null )
    {
      Display.target.draw(this, position, mirroring, rotation, scale, alpha );
    }
    else
    {
      throw new AssertionError();
    }
  }
}
