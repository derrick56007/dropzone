import 'dart:async';

import 'package:universal_html/html.dart' as html;

class Dispatcher {
  static final shared = Dispatcher._internal();

  late StreamSubscription<html.MouseEvent> _onDragOverSubscription;
  late StreamSubscription<html.MouseEvent> _onDropSubscription;

  final _dragFunctions = <int, Function(html.MouseEvent)>{};
  final _dropFunctions = <int, Function(html.MouseEvent)>{};

  var currentZoneId = 0;

  Dispatcher._internal() {
    _onDropSubscription = html.document.body!.onDrop.listen(_onDrop);
    _onDragOverSubscription =
        html.document.body!.onDragOver.listen(_onDragOver);
  }

  void cancel() {
    _onDropSubscription.cancel();
    _onDragOverSubscription.cancel();
  }

  int addZone(
      {Function(html.MouseEvent e)? onDragOver,
      Function(html.MouseEvent e)? onDrop}) {
    if (onDragOver != null) {
      _dragFunctions[currentZoneId] = onDragOver;
    }

    if (onDrop != null) {
      _dropFunctions[currentZoneId] = onDrop;
    }

    return currentZoneId++;
  }

  void removeZone(int id) {
    _dragFunctions.remove(id);
    _dropFunctions.remove(id);
  }

  void _stopEvent(html.MouseEvent e) => e
    ..stopPropagation()
    ..stopImmediatePropagation()
    ..preventDefault();

  void _onDrop(html.MouseEvent e) {
    _stopEvent(e);

    for (final f in _dropFunctions.values) {
      f(e);
    }
  }

  void _onDragOver(html.MouseEvent e) {
    _stopEvent(e);

    for (final f in _dragFunctions.values) {
      f(e);
    }
  }
}
