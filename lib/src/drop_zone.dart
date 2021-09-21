import 'package:drop_zone/src/dispatcher.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

class DropZone extends StatefulWidget {
  const DropZone({
    required this.child,
    Key? key,
    this.onDrop,
    this.onDragEnter,
    this.onDragExit,
  }) : super(key: key);

  final void Function(List<html.File>? files)? onDragEnter;
  final void Function()? onDragExit;
  final void Function(List<html.File>? files, Offset offset)? onDrop;

  final Widget child;

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
        widget.onDragEnter?.call(e.dataTransfer.files);
      } else if (_dragInBounds && !tmp) {
        widget.onDragExit?.call();
      }

      _dragInBounds = tmp;
    }, onDrop: (e) {
      if (_isCursorWithinBounds(e)) {
        widget.onDrop?.call(
          e.dataTransfer.files,
          Offset(e.offset.x as double, e.offset.y as double),
        );
      }
    });
  }

  @override
  Widget build(BuildContext c) => widget.child;
}
