import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/widgets.dart';

class DropZone extends StatefulWidget {
  final Widget child;
  final Function() onDragEnter;
  final Function() onDragExit;

  final Function(List<html.File>) onDrop;

  const DropZone({
    @required this.child,
    Key key,
    this.onDrop,
    this.onDragEnter,
    this.onDragExit,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  StreamSubscription<html.MouseEvent> _onDragOverSubscription;
  StreamSubscription<html.MouseEvent> _onDropSubscription;
  bool _dragInBounds = false;

  Rect _getGlobalPaintBounds() {
    final renderObject = context?.findRenderObject();
    final translation = renderObject?.getTransformTo(null)?.getTranslation();

    if (translation != null && renderObject.paintBounds != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    }

    return null;
  }

  @override
  void dispose() {
    _onDropSubscription.cancel();
    _onDragOverSubscription.cancel();

    super.dispose();
  }

  void _onDrop(html.MouseEvent value) {
    value
      ..stopPropagation()
      ..stopImmediatePropagation()
      ..preventDefault();

    widget.onDrop?.call(value.dataTransfer.files);
  }

  void _onDragOver(html.MouseEvent value) {
    value
      ..stopPropagation()
      ..stopImmediatePropagation()
      ..preventDefault();

    final tmp = _isCursorWithinBounds(value);
    if (!_dragInBounds && tmp) {
      widget.onDragEnter?.call();
    } else if (_dragInBounds && !tmp) {
      widget.onDragExit?.call();
    }

    _dragInBounds = tmp;
  }

  bool _isCursorWithinBounds(html.MouseEvent value) {
    final g = _getGlobalPaintBounds();

    return g != null && //
        value.layer.x > g.left &&
        value.layer.x < g.right &&
        value.layer.y > g.top &&
        value.layer.y < g.bottom;
  }

  @override
  void initState() {
    super.initState();

    _onDropSubscription = html.document.body.onDrop.listen(_onDrop);
    _onDragOverSubscription = html.document.body.onDragOver.listen(_onDragOver);
  }

  @override
  Widget build(BuildContext c) => widget.child;
}
