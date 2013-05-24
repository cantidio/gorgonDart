/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a Font
 */
class Font
{
  Future<Font> _onLoad = new Completer().future;
  String _family = "";

  /// Returns the family name generated for the font
  String get family => _family;

  /// Returns the onLoad future of the font
  Future<Font> get onLoad => _onLoad;

  /// The default color to draw with this font
  Color color;

  /// The default size of the font
  int size;

  /// The default alignment used by the font
  FontAlignment alignment = FontAlignment.left;

  Timer _watchdog_timer;  // The watchdog timer
  int _watchdog_runs;     // How many times the watchdog has run
  int _watchdog_max = 20; // The max number the watchdog is granted to run

  /**
   * Method that creates a [Font] with the [fontUrl] provided.
   *
   * You can provide along with the [fontUrl] a default [size] and a default [alignment].
   * These will work as default values and will be used for every draw operation that you don't
   * set another alignment and size by yourself.
   *
   * The load completion can be checked using the [onLoad] [Future] getter.
   */
  Font({ String fontUrl, int size: 12, FontAlignment alignment: FontAlignment.left, Color color: null })
  {
    if( fontUrl != null )
    {
      load( fontUrl, size: size, alignment: alignment, color: color );
    }
    else
    {
      this.size      = size;
      this.alignment = alignment;
      this.color     = (color != null ) ? color : new Color();
    }
  }

  /**
   * Method that loads a [Font] given its [fontUrl].
   *
   * This method will created a font-face entry in the [document.head] with the given [fontUrl].
   *
   * You can provide along with the [fontUrl] a default [size], a default [alignment] and a default [color].
   * These will work as default values and will be used for every draw operation that you don't
   * set another [alignment], [size] and [color] by yourself.
   *
   * This method returns a [Future]<[Font]> which can be checked for the font load completion.
   */
  Future<Font> load( String fontUrl, {int size: 12, FontAlignment alignment: FontAlignment.left, Color color: null} )
  {
    Completer completer = new Completer();
    Element style       = new Element.tag("style");
    _family             = fontUrl.substring( fontUrl.lastIndexOf("/") + 1);
    _family             = _family.replaceAll(".", "") + new DateTime.now().millisecondsSinceEpoch.toString();
    this.size           = size;
    this.color          = (color != null ) ? color : new Color();
    this.alignment      = alignment;

    style.appendHtml( "@font-face{ font-family: '$_family'; src: url('$fontUrl'); }" );
    document.head.append( style );

    //The following code runs until the font is loaded or we get a timeout.
    _watchdog_runs  = 0;
    _watchdog_timer = new Timer.periodic( const Duration(milliseconds: 25), (_) {
      if( _isFontLoaded() )
      {
        _watchdog_timer.cancel();
        _watchdog_timer = null;
        completer.complete(this);
      }
      else if( _watchdog_runs++ > _watchdog_max )
      {
        _watchdog_timer.cancel();
        _watchdog_timer = null;
        style.remove();
        completer.completeError( new Exception("Timeout loading font: "+fontUrl ) );
      }
    });
    _onLoad = completer.future;
    return onLoad;
  }

  /**
   * Method that checks if the [Font] has loaded.
   *
   * The method will return [true] if the [Font] is loaded or [false] otherwise.
   */
  bool _isFontLoaded()
  {
    int width, height;
    List<String> fonts  = ["monospace","sans-serif","serif",""];
    String text         = "WwiI?";
    int fontSize        = 70;

    CanvasElement canvas = new CanvasElement(width: fontSize*text.length, height: fontSize);
    for( String font in fonts )
    {
      canvas.context2D.clearRect( 0, 0, canvas.width, canvas.height );
      canvas.context2D.fillStyle = "rgba(0,0,255,255)";
      canvas.context2D.font      = "${fontSize}px $_family, $font";
      canvas.context2D.fillText( text, 0, fontSize );

      ImageData data1 = canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);

      canvas.context2D.clearRect( 0, 0, canvas.width, canvas.height );
      canvas.context2D.font      = "${fontSize}px $font";
      canvas.context2D.fillText( text, 0, fontSize );

      ImageData data2 = canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);

      for( int i = 0; i < data1.data.length; ++i )
      {
        if(data1.data[i] != data2.data[i])
        {
          return true;
        }
      }
    }
    return false;
  }
  /**
   * Method that writes/draws a [text] into the target [Display].
   *
   * This method will draw the requested [text] into the target [Display].
   * You should set the [text] and the [position] it should be drawn in the [Display].
   *
   * You can set the [color], the [alignment] and the [size] in pixels of the [text].
   * If you don't these these values, then the default values will be used.
   */
  void drawText( Point2D position, String text, { Color color, FontAlignment alignment, int size })
  {
    if( Display.target != null )
    {
      size      = ( size      != null ) ? size      : this.size;
      color     = ( color     != null ) ? color     : this.color;
      alignment = ( alignment != null ) ? alignment : this.alignment;

      Display.target.drawText( this, position, text, alignment, color, size );
    }
    else
    {
      throw new AssertionError();
    }
  }
}