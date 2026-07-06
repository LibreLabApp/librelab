import 'package:flutter/material.dart';

@immutable
class const ActionToggleItem<T>({
  required final T value,
  required final Widget icon,
  required final String? tooltip,
});

class const AdaptiveToggleGroup<T>({
  super.key,
  required final void Function(BuildContext context, T value)
  _onSelectionChanged,
  required final T _selected,
  required final List<ActionToggleItem<T>> _items,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: _items
            .map(
              (e) => IconButton.filledTonal(
                icon: e.icon,
                onPressed: () => _onSelectionChanged(context, e.value),
                tooltip: e.tooltip,
                isSelected: e.value == _selected,
                selectedIcon: const Icon(Icons.check),
              ),
            )
            .toList(),
      );
    }

    return SegmentedButton<T>(
      showSelectedIcon: true,
      segments: _items.map((e) {
        return ButtonSegment<T>(
          value: e.value,
          icon: e.icon,
          tooltip: e.tooltip,
        );
      }).toList(),
      selected: <T>{_selected},
      onSelectionChanged: (Set<T> newSelection) =>
          _onSelectionChanged(context, newSelection.first),
    );
  }
}
