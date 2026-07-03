import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

class const SettingsSection({
  super.key,
  required final String title,
  required final List<Widget> tiles,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: textScaler.scale(24),
            bottom: textScaler.scale(10),
            start: 24,
            end: 24,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: context.theme.brightness == .dark
                  ? const Color(0xffd3e3fd)
                  : const Color(0xff0b57d0),
            ),
            child: Text(title),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tiles.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => tiles[index],
        ),
      ],
    );
  }
}
