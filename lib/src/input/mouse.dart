/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;

/**
 * Class that represents a keyboard.
 */
class Mouse
{
  Map<int,bool> _buttonBuffer;
  List _keyDownCallback;
  List _keyUpCallback;
  List _onMoveCallback;

  Point2D _position;
  Stream<Point2D> _onMoveStream;

  Stream<Point2D> get onMove => _onMoveStream;
  Point2D get position => _position;

  /// Returns all keycodes being pressed.
  List<int> get pressedButtons => _keyBuffer.keys.toList(growable: false);

  /**
   * [Mouse] constructor.
   */
  Mouse()
  {
    _mousePosition   = new Point2D.zero();
    _buttonBuffer    = new Map<int,bool>();
    _registerEvents();
  }

  /**
   * Method that clears the key buffer.
   */
  void onMove( callback )
  {
    _onMoveCallback.add( callback );
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
    _onMoveStream = window.onMouseMove.map((event) => new Point2D( event.clientX, event.clientY ));
    onMove.listen((event) => _onMove( event ) );

    //window.onMouseWheel.listen((event) => _onWheel     ( event ) );
    //window.onMouseDown.listen ((event) => _onButtonDown( event ) );
    //window.onMouseUp.listen   ((event) => _onButtonUp  ( event ) );
  }

  /**
   * Method callec everytime the mouse moves
   */
  void _onMove( MouseEvent event )
  {
    _mousePosition = new Point2D( event.clientX, event.clientY );
  }

  /**
   * Method called everytime a Button is pressed down.
   */
  void _onButtonDown( MouseEvent event )
  {
    if( _buttonBuffer[event.button] != true )
    {
      _buttonBuffer[event.button] = true;
      _buttonDownCallback.forEach((e) => e(event.button));
    }
  }
  /**
   * Method called everytime a Button is released
   */
  void _onKeyUp( MouseEvent event )
  {
    if( _buttonBuffer[event.button] != null )
    {
      _buttonBuffer.remove( event.button );
      _buttonUpCallback.forEach((e) => e(event.button));
    }
  }

}


