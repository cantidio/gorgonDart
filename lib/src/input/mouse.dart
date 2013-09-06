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
  Point2D         _position;
  Stream<Point2D> _onMoveStream;
  Stream<int>     _onButtonDownStream;
  Stream<int>     _onButtonUpStream;
  Map<int,bool>   _buttonBuffer;

  Point2D         get position      => _position;
  Stream<Point2D> get onMove        => _onMoveStream;
  Stream<int>     get onButtonDown  => _onButtonDownStream;
  Stream<int>     get onButtonUp    => _onButtonUpStream;

  /// Returns all keycodes being pressed.
  List<int> get pressedButtons => _buttonBuffer.keys.toList(growable: false);

  /**
   * [Mouse] constructor.
   */
  Mouse()
  {
    _position     = new Point2D.zero();
    _buttonBuffer = new Map<int,bool>();
    _registerEvents();
  }

  /**
   * Operator that returns [true] if the [button] is pressed [false] otherwise.
   */
  bool operator []( int button )
  {
    return _buttonBuffer[button] != null ? _buttonBuffer[button] : false;
  }

  /**
   * Method that registers the necessary events
   */
  void _registerEvents()
  {
    _onButtonDownStream = window.onMouseDown.map((event) => event.button );
    _onButtonUpStream   = window.onMouseUp.map  ((event) => event.button );
    _onMoveStream       = window.onMouseMove.map((event) => new Point2D( event.clientX, event.clientY ));

    onButtonDown.listen ((event) => _onButtonDown ( event ));
    onButtonUp.listen   ((event) => _onButtonUp   ( event ));
    onMove.listen       ((event) => _onMove       ( event ));
  }

  /**
   * Method callec everytime the mouse moves
   */
  void _onMove( Point2D position )
  {
    _position = position;
  }

  /**
   * Method called everytime a [button] is pressed down.
   */
  void _onButtonDown( int button )
  {
    if( _buttonBuffer[button] != true )
    {
      _buttonBuffer[button] = true;
    }
  }
  /**
   * Method called everytime a [button] is released
   */
  void _onButtonUp( int button )
  {
    if( _buttonBuffer[button] != null )
    {
      _buttonBuffer.remove( button );
    }
  }

}


