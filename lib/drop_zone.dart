// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/widgets.dart';

import 'dispatcher.dart';

class DropZone extends StatefulWidget {
  final Widget child;
  final void Function()? onDragEnter;
  final void Function()? onDragExit;

  final void Function(List<html.File>?)? onDrop;

  const DropZone({
    required this.child,
    Key? key,
    this.onDrop,
    this.onDragEnter,
    this.onDragExit,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DropZoneState();
}

class DropZoneState extends State<DropZone> {
  late int id;
  bool _dragInBounds = false;

  Rect? _getGlobalPaintBounds() {
    final renderObject = context.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();

    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject?.paintBounds
          .shift(Offset(translation.x, translation.y));
    }

    return null;
  }

  @override
  void dispose() {
    Dispatcher.shared.removeZone(id);

    super.dispose();
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

    id = Dispatcher.shared.addZone(onDragOver: (e) {
      final tmp = _isCursorWithinBounds(e);
      if (!_dragInBounds && tmp) {
        widget.onDragEnter?.call();
      } else if (_dragInBounds && !tmp) {
        widget.onDragExit?.call();
      }

      _dragInBounds = tmp;
    }, onDrop: (e) {
      if (_isCursorWithinBounds(e)) {
        widget.onDrop?.call(e.dataTransfer.files);
      }
    });
  }

  @override
  Widget build(BuildContext c) => widget.child;
}
