/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;

abstract class Filter
{
  static CanvasElement canvas = new CanvasElement();
  ImageData apply(ImageData data);
}
class FilterGrayscale extends Filter
{
  ImageData apply(ImageData data)
  {
    for( int i = 0; i < data.data.length; i= i+4 )
    {
      // CIE luminance for the RGB
      double v = data.data[i] * 0.2126 + data.data[i+1] * 0.7152 + data.data[i+2] * 0.0722;
      data.data[i] = data.data[i+1] = data.data[i+2] = v.toInt();
    }
    return data;
  }
}
class FilterConvolute extends Filter
{
  List<int> weights;
  bool opaque;

  FilterConvolute( this.weights, [this.opaque=false]);

  ImageData apply( ImageData data )
  {
    int side          = sqrt(weights.length).round();
    int halfSide      = (side/2).floor();
    ImageData output  = Filter.canvas.context2D.createImageData( data.width, data.height );

    // go through the destination image pixels
    int alphaFac = opaque ? 1 : 0;
    for( int y = 0; y <  data.height; y++ )
    {
      for( int x = 0; x < data.width; x++ )
      {
        int dstOff = ( y * data.width + x) * 4;
        // calculate the weighed sum of the source image pixels that
        // fall under the convolution matrix
        int r=0, g=0, b=0, a=0;
        for( int cy = 0; cy < side; cy++ )
        {
          for( int cx = 0; cx < side; cx++ )
          {
            var scy = y + cy - halfSide;
            var scx = x + cx - halfSide;
            if( scy >= 0 && scy < data.height && scx >= 0 && scx < data.width )
            {
              var srcOff = (scy*data.width+scx)*4;
              var wt = weights[cy*side+cx];
              r += data.data[srcOff] * wt;
              g += data.data[srcOff+1] * wt;
              b += data.data[srcOff+2] * wt;
              a += data.data[srcOff+3] * wt;
            }
          }
        }
        output.data[dstOff]   = r;
        output.data[dstOff+1] = g;
        output.data[dstOff+2] = b;
        output.data[dstOff+3] = a + alphaFac*(255-a);
      }
    }
    return output;
  }
}

class FilterSolbel extends Filter
{
  ImageData apply(ImageData data)
  {
    data                  = new FilterGrayscale().apply(data);
    ImageData vertical    = new FilterConvolute([-1,0,1,-2,0,2,-1,0,1]).apply(data);
    ImageData horizontal  = new FilterConvolute([-1,-2,-1,0,0,0,1,2,1]).apply(data);

    for( int i=0; i<data.data.length; i+=4 )
    {
      int v = vertical.data[i].abs();
      int h = horizontal.data[i].abs();

      data.data[i]    = v;        // make the vertical gradient red
      data.data[i+1]  = h;        // make the horizontal gradient green
      data.data[i+2]  = (v+h)~/4;  // and mix in some blue for aesthetics
      data.data[i+3]  = 255;      // opaque alpha
    }
    return data;
  }
}

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
   * **Warning** If you set the [stretchToFill] as [true] and the provided [target] doesn't have a defined width or height.
   * Then this option will be ignored.
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

    if( stretchToFill && _parent.clientWidth != 0 &&  _parent.clientHeight != 0 )
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
   * Method that requests the display to be shown in fullscreen
   */
  void requestFullScreen()
  {
    _canvas.requestFullScreen();
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
  /**
   * Method that writes/draws a [text] into the [Display].
   *
   * **Warning**: You don't need to use this method directly, you can use the [Font.drawText] instead.
   *
   * This method will draw the requested [text] into the [Display] using the provided [Font].
   * You should set the [position] that this text should be drawn, it's [alignment], it's [color]
   * and it's [size] in pixels.
   */
  void drawText( Font font, Point2D position, String text, FontAlignment alignment, Color color, int size )
  {
    if( font != null )
    {
      size      = ( size      != null ) ? size      : font.size;
      color     = ( color     != null ) ? color     : font.color;
      alignment = ( alignment != null ) ? alignment : font.alignment;

      _canvas.context2D.save();
      _canvas.context2D.font      = "${size}px ${font.family}";
      _canvas.context2D.fillStyle = "rgba(${color.r},${color.g},${color.b},${color.a})";
      _canvas.context2D.fillText( text, position.x, position.y );
      _canvas.context2D.restore();
    }
  }
  void filter( Filter filter )
  {
    ImageData data = filter.apply( _canvas.context2D.getImageData(0, 0, width, height) );
    _canvas.context2D.putImageData( data, 0, 0 );
  }
}
