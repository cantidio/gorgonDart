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
  
  ImageData   _data; /// The ImageData of the sprite                
  Map         _colorMap = new Map();  /// The ColorMap of the sprite
  
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
      
      if( _width > 0 && _height > 0 )
      {
        CanvasElement canvas = new CanvasElement( width: width, height: height );
        
        canvas.context2D.drawImage( _image, 0, 0 );
        this._data = canvas.context2d.getImageData(0, 0, width, height);
        
        _colorMap.clear();
      }
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
  /**
   * Method that rotates the [Sprite] 90 degrees to the right.
   * 
   * This method returns a [Future]<[Sprite]> which can be checked for the method completion.
   */
  Future<Sprite> rotateRight()
  {
    CanvasElement canvas = new CanvasElement(width: height, height: width);
    canvas.context2d.translate( height, 0 );
    canvas.context2d.rotate( 90 * PI / 180 );
    canvas.context2d.drawImage( _image, 0, 0 );
    
    double y = offset.y;
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
    canvas.context2d.translate( 0, width );
    canvas.context2d.rotate( -90 * PI / 180 );
    canvas.context2d.drawImage( _image, 0, 0 );
    
    double x = offset.x;
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
    canvas.context2d.translate(width, 0);
    canvas.context2d.scale(-1, 1);
    canvas.context2d.drawImage(_image, 0, 0);

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
    canvas.context2d.translate(0, height);
    canvas.context2d.scale(1, -1);
    canvas.context2d.drawImage(_image, 0, 0);

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
    canvas.context2d.translate(width, height);
    canvas.context2d.scale(-1, -1);
    canvas.context2d.drawImage(_image, 0, 0);

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
    }
  }
  /**
   * Operator that returns one [line] of [Color]s in a [List].
   * 
   * * This operator caches the data for further use. 
   * 
   * @todo verify why on 8bit images the values returned are different. In javascript are they different as well?
   */
  List<Color> operator []( int line )
  {
    if( _colorMap[line] == null )
    {
      int begin = line * width * 4;
      _colorMap[line] = new List<Color>();
      for( int i = 0; i < width; ++i )
      {
        _colorMap[line].add( new Color(
            r: _data.data[begin+0], 
            g: _data.data[begin+1],
            b: _data.data[begin+2], 
            a: _data.data[begin+3] 
        ));
        begin += 4;
      }
    }    
    return _colorMap[line];
  }
  /**
   * Operator that checks if the content of 2 [Sprite]s are the same.
   * 
   * * This will check every image pixel.
   */
  operator == (Sprite other) 
  {
    if( width == other.width && height == other.height && offset == other.offset )
    {
      for( int h = 0; h < height; ++h)
      {
        for( int w = 0; w < width; ++w)
        {
          if( this[h][w] != other[h][w])
          {
            return false;
          }
        }
      }
      return true;
    }
    return false;
  }
}
