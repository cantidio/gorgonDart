/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;

/**
 * Class that represents a keyboard.
 */
class Keyboard
{
  Map<int,bool> _keyBuffer;
  List _keyDownCallback;
  List _keyUpCallback;

  /// Returns all keycodes being pressed.
  List<int> get pressedKeys => _keyBuffer.keys.toList(growable: false);

  /**
   * Keyboard constructor.
   */
  Keyboard()
  {
    _keyBuffer       = new Map<int,bool>();
    _keyDownCallback = new List();
    _keyUpCallback   = new List();
    _registerEvents();
  }

  /**
   * Method that clears the key buffer.
   */
  void clearKeyBuffer()
  {
    _keyBuffer.clear();
  }

  /**
   * Method that register a [callback] that will be called when a key is Up.
   */
  void onKeyUp( callback )
  {
    _keyUpCallback.add( callback );
  }

  /**
   * Method that register a [callback] that will be called when a key is Down.
   */
  void onKeyDown( callback )
  {
    _keyDownCallback.add( callback );
  }

  /**
   * Operator that returns [true] if the [key] isß pressed [false] otherwise.
   */
  bool operator []( int key )
  {
    return _keyBuffer[key] != null ? _keyBuffer[key] : false;
  }

  /**
   * Method that registers the necessary events
   */
  void _registerEvents()
  {
    window.onKeyDown.listen((event) => _onKeyDown( event ) );
    window.onKeyUp.listen  ((event) => _onKeyUp  ( event ) );
    //window.onFocus
    //window.onBlur
  }

  /**
   * Method called everytime a Key is pressed down.
   */
  void _onKeyDown( event )
  {
    if( _keyBuffer[event.keyCode] != true )
    {
      _keyBuffer[event.keyCode] = true;
      _keyDownCallback.forEach((e) => e(event.keyCode));
    }
  }
  /**
   * Method called everytime a Key is released
   */
  void _onKeyUp( event )
  {
    if( _keyBuffer[event.keyCode] != null )
    {
      _keyBuffer.remove( event.keyCode );
      _keyUpCallback.forEach((e) => e(event.keyCode));
    }
  }

}


