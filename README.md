# drop_zone

[![pub package](https://img.shields.io/pub/v/drop_zone.svg)](https://pub.dev/packages/drop_zone)
![License](https://img.shields.io/github/license/derrick56007/drop_zone)

A simple way to bring drag’n’drop to flutter web.

drop_zone is commonly used for file choosing by dragging and dropping a file(s) onto a designated widget. The user can then use the dropped html file(s).

![](demo.gif?raw=true)

## Example

An example can be found in the example directory of this repository.

## How to use

Add `drop_zone` to `pubspec.yaml` of your project:

```yaml
dependencies:
  drop_zone: ^0.0.1
```

Add necessary imports and wrap any widget with `DropZone()` to use it as a dropzone:

```dart
import 'package:drop_zone/drop_zone.dart';
import 'dart:html' as html;

DropZone(
    onDragEnter: () {
        print('drag enter');
    },
    onDragExit: () {
        print('drag exit');
    },
    onDrop: (List<html.File> files) {
        print('files dropped');
        print(files);
    },
    child: Container(
        width: 300,
        height: 300,
    )
)
```

## License

[MIT License](https://github.com/derrick56007/drop_zone/blob/main/LICENSE).
