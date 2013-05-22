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
  String _family;


  /// Returns the onLoad future of the font
  Future<Font> get onLoad => _onLoad;


  Timer _watchdog_timer;  // The watchdog timer
  int _watchdog_runs;     // How many times the watchdog has run
  int _watchdog_max = 10; // The max number the watchdog is granted to run


  /**
   * Method that creates a [Font] with the [fontUrl] provided.
   *
   * The load completion can be checked using the [onLoad] [Future] getter.
   */
  Font({String fontUrl})
  {
    if( fontUrl != null )
    {
      load( fontUrl );
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
  Future<Font> load( String fontUrl )
  {
    Completer completer = new Completer();
    Element style = new Element.tag("style");
    _family = fontUrl.substring( fontUrl.lastIndexOf("/") + 1) + new DateTime.now().millisecondsSinceEpoch.toString();
    _family = _family.replaceAll(".", "");

    style.appendHtml( "@font-face{ font-family: '$_family'; src: url('$fontUrl'); }" );
    document.head.append(style);

    //The following code runs until the font is loaded or we get a timeout.
    _watchdog_runs = 0;
    _watchdog_timer = new Timer.periodic( const Duration(milliseconds: 25), (_) {
      Element span = new Element.tag("span");
      document.body.append(span);

      span.style.fontSize   = "10px";
      span.style.position   = "absolute";
      span.style.top        = "-100px";
      span.style.left       = "-100px";
      span.text             = "text";
      int before            = span.clientWidth;
      span.style.fontFamily = _family;
      int after             = span.clientWidth;
      span.remove();

      if( before != after )
      {
        _watchdog_timer.cancel();
        completer.complete(this);
      }
      else if( _watchdog_runs++ > _watchdog_max )
      {
        _watchdog_timer.cancel();
        completer.completeError( new Exception("timeout loading font: "+fontUrl ) );
      }
    });
    _onLoad = completer.future;
    return onLoad;
  }
}