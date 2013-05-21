/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a display
 */
class Display
{
  static Display _target;                 // The current target display
  Element       _parent;                  // The element where our canvas will be placed
  CanvasElement _canvas;                  // The canvas element of the display
  Point2D       _scale = new Point2D(1,1);// The current scale of the display
  int           _originalWidth = 0;       // The original width of the display
  int           _originalHeight = 0;      // The original height of the display

  /// Return the current display target
  static Display get target => _target;

  /// Return the original width of the display
  int get width => _originalWidth;

  /// Return the original height of the display
  int get height => _originalHeight;

  /// Return the current scale of the display
  Point2D get scale => _scale;

  /**
   * Creates a [Display] and assign it to the provided [target] which must be a DOM [Element].
   *
   * You must provide the desired [width] and [height] as integers.
   *
   * If you set the [stretchToFill] as [true] then the display will be stretched to fill the provided [target].
   * For that it will set the scale to the canvas for matching the size of the [target].
   *
   * The [imageSmoothing] is setted to [false] as default. You can turn it on by setting it to [true].
   */
  Display( Element target, { int width: 300, int height: 150, bool stretchToFill: false , bool imageSmoothing: false } )
  {
    _parent         = target;

    if( width <= 0 || height <= 0 )
    {
      throw new FormatException("The Display width and height values must be higher than 0.");
    }

    _originalWidth  = width;
    _originalHeight = height;

    if( stretchToFill )
    {
      width     = _parent.clientWidth;
      height    = _parent.clientHeight;
      _scale.x  = _parent.clientWidth / _originalWidth;
      _scale.y  = _parent.clientHeight / _originalHeight;
    }

    _canvas = new CanvasElement( width: width, height: height );
    _canvas.context2D.imageSmoothingEnabled = imageSmoothing;
    _canvas.context2D.scale( scale.x, scale.y );
    _parent.append(_canvas);

    if( _target == null )
    {
      setAsTarget();
    }
  }

  /**
   * Method that set the [Display] as target for further drawings operations.
   *
   * If this method was never called then the [target] [Display] will be the first created display.
   */
  void setAsTarget()
  {
    _target = this;
  }

  /**
   * Method used to rescale the [CanvasElement].
   *
   * This method **must** be used when setting the new [scale] of the [CanvasElement].
   */
  void _rescale( Point2D scale )
  {
    _canvas.context2D.scale( 1/_scale.x, 1/_scale.y );
    _canvas.context2D.scale( scale.x, scale.y );
    _scale = scale;
  }

  /**
   * Method that clears the [Display]
   */
  void clear()
  {
    _canvas.context2D.save();
    _canvas.context2D.setTransform(1, 0, 0, 1, 0, 0);
    _canvas.context2D.clearRect(0, 0, width * scale.x, height * scale.y);
    _canvas.context2D.restore();
  }
  /**
   * Method that draws a [Sprite] [sprite] in the [Display].
   *
   * **Warning**: You don't need to use this method directly, you can use the [Sprite.draw] instead.
   *
   * You must provide:
   *
   * The [position] as a [Point2D] which will tell where to draw the [sprite] in the [Display].
   *
   * The [mirroring] as a [Mirroring] which will tell what kind of mirroring to apply to the drawing operation.
   *
   * The [rotation] as a [num] which will tell if the sprite must be drawn using rotation or not.
   *
   * The [scale] as a [num] which will define the [sprite] scale to be used when drawing. The default is: 1;
   */
  void draw( Sprite sprite, Point2D position, Mirroring mirroring, num rotation, num scale, int alpha )
  {
    if( sprite != null )
    {
      _canvas.context2D.save();
      _canvas.context2D.globalAlpha = alpha/255.0;

      switch( mirroring )
      {
        case Mirroring.H:
            _canvas.context2D.translate( position.x , position.y );
            _canvas.context2D.scale( -scale, scale );
            _canvas.context2D.rotate( -rotation * PI / 180 );
          break;

        case Mirroring.V:
            _canvas.context2D.translate( position.x , position.y );
            _canvas.context2D.scale( scale, -scale );
            _canvas.context2D.rotate( -rotation * PI / 180 );
          break;

        case Mirroring.HV:
          _canvas.context2D.translate( position.x , position.y );
          _canvas.context2D.scale( -scale, -scale );
          _canvas.context2D.rotate( rotation * PI / 180 );
          break;

        case Mirroring.None:
            _canvas.context2D.translate( position.x , position.y );
            _canvas.context2D.scale( scale, scale );
            _canvas.context2D.rotate( rotation * PI / 180 );
          break;
      }
      _canvas.context2D.translate( sprite.offset.x , sprite.offset.y );
      _canvas.context2D.drawImage( sprite.image, 0, 0 );
      _canvas.context2D.restore();
    }
  }
}