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
  Stream<int> _onKeyDownStream;
  Stream<int> _onKeyUpStream;

  /// Returns the [Stream] of KeyDown
  Stream<int> get onKeyDown => _onKeyDownStream;
  /// Returns the [Stream] of KeyUp
  Stream<int> get onKeyUp   => _onKeyUpStream;
  /// Returns all keycodes being pressed.
  List<int> get pressedKeys => _keyBuffer.keys.toList(growable: false);

  /**
   * Keyboard constructor.
   */
  Keyboard()
  {
    _keyBuffer = new Map<int,bool>();
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
    _onKeyDownStream = window.onKeyDown.map((event) => event.keyCode);
    _onKeyUpStream   = window.onKeyUp.map  ((event) => event.keyCode);
    onKeyDown.listen((event) => _onKeyDown( event ) );
    onKeyUp.listen  ((event) => _onKeyUp  ( event ) );
  }

  /**
   * Method called everytime a Key is pressed down.
   */
  void _onKeyDown( event )
  {
    if( _keyBuffer[event] != true )
    {
      _keyBuffer[event] = true;
    }
  }
  /**
   * Method called everytime a Key is released
   */
  void _onKeyUp( event )
  {
    if( _keyBuffer[event] != null )
    {
      _keyBuffer.remove( event );
    }
  }

}


