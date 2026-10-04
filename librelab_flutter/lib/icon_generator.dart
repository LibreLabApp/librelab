import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:librelab_flutter/common/ui/widgets/librelab/librelab_icon.dart';
import 'package:material_ui/material_ui.dart';

/// A standalone tool for generating LibreLab icon assets.
///
/// This entry point is not used by the LibreLab application itself.
void main() => runApp(const _MainApp());

class const _MainApp() extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(debugShowCheckedModeBanner: false, home: _MainPage());
}

class const _MainPage() extends StatefulWidget {
  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  bool _isFramedIcon = true;

  final GlobalKey iconKey = GlobalKey();

  Future<void> _save() async {
    final boundary =
        iconKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: .png);

    final pngBytes = byteData!.buffer.asUint8List();

    final file = File('icon.png');
    await file.writeAsBytes(pngBytes);

    final localContext = context;
    if (!localContext.mounted) {
      return;
    }

    final scaffoldMessenger = ScaffoldMessenger.of(localContext);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Saved PNG: ${pngBytes.length} bytes"'),
        action: SnackBarAction(
          label: 'Copy File Path',
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: file.absolute.path)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: .center,
          spacing: 14,
          children: [
            Checkbox.adaptive(
              value: _isFramedIcon,
              onChanged: (value) => setState(() => _isFramedIcon = value!),
            ),
            const Text('Framed Icon', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save',
        mouseCursor: .defer,
        onPressed: _save,
        child: const Icon(Icons.download),
      ),
      body: Center(
        child: RepaintBoundary(
          key: iconKey,
          child: FittedBox(
            fit: .cover,
            child: SizedBox(
              width: 512,
              height: 512,
              child: _isFramedIcon
                  ? LibreLabIcon.framed(
                      borderWidth: 6,
                      padding: const EdgeInsets.all(72),
                    )
                  : Center(child: LibreLabIcon.nonFramed()),
            ),
          ),
        ),
      ),
    );
  }
}
