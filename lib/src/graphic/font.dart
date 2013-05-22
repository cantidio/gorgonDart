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
   * The load completion can be checked using the [onLoad] [Future] getter.
   */
  Font({String fontUrl, int size: 12, FontAlignment alignment: FontAlignment.left})
  {
    if( fontUrl != null )
    {
      load( fontUrl, size );
    }
    else
    {
      this.size      = size;
      this.alignment = alignment;
    }
  }

  /**
   * Method that loads a [Font] given its [fontUrl].
   *
   * This method will created a font-face entry in the [document.head] with the given [fontUrl].
   *
   * This method returns a [Future]<[Font]> which can be checked for the font load completion.
   *
   * @todo try changing the watchdog checking method for drawing in a canvas.
   */
  Future<Font> load( String fontUrl, {int size: 12, FontAlignment alignment: FontAlignment.left} )
  {
    Completer completer = new Completer();
    Element style       = new Element.tag("style");
    _family             = fontUrl.substring( fontUrl.lastIndexOf("/") + 1); 
    _family             = _family.replaceAll(".", "") + new DateTime.now().millisecondsSinceEpoch.toString();
    this.size           = size;
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
        completer.completeError( new Exception("timeout loading font: "+fontUrl ) );
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
    Element span        = new Element.tag("span");
    document.body.append( span );
    
    span.style.fontSize   = "72px";
    span.text             = "wwwiii";
    
    for( String font in fonts )
    {
      span.style.fontFamily = "$_family, $font";
      width                 = span.offsetWidth;
      height                = span.offsetHeight;
      span.style.fontFamily = font;
      
      if( span.offsetWidth != width && span.offsetHeight != height )
      {
        span.remove();
        return true;
      }
    }
    span.remove();
    return false;
  }
}