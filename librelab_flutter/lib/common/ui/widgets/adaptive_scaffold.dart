import 'package:material_ui/material_ui.dart';

@immutable
class const NavigationItem({
  required final Widget unselectedIcon,
  required final Widget selectedIcon,
  required final String label,

  required final Widget body,

  /// Only applicable for [NavigationBar].
  /// [NavigationBar] defaults to the value of [label] if tooltip
  /// is not provided.
  final String? tooltip,
});

typedef FloatingActionButtonBuilder = Widget? Function(
  BuildContext context,
  int index,
);

/// A scaffold that adapts its navigation layout to the available width.
///
/// Uses a [NavigationRail] when the available width is wide enough and a
/// [NavigationBar] when it is not. The decision is based on screen width,
/// not the underlying platform or operating system.
class const AdaptiveScaffold({
  super.key,
  final PreferredSizeWidget? Function(
    List<Widget> actions, {
    required bool isNavigationRail,
  })?
  appBar,
  required final List<NavigationItem> navigationItems,
  required final List<Widget> Function({required bool isNavigationRail})
  actions,
  required final int defaultIndex,
  final FloatingActionButtonBuilder? floatingActionButtonBuilder,
}) extends StatefulWidget {
  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  var _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.defaultIndex;
    super.initState();
  }

  Widget _buildBody(bool useNavigationRail) {
    final body = widget.navigationItems[_selectedIndex].body;

    if (!useNavigationRail) {
      return body;
    }
    return Row(
      children: [
        NavigationRail(
          labelType: .selected,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
          destinations: widget.navigationItems
              .map(
                (e) => NavigationRailDestination(
                  icon: e.unselectedIcon,
                  selectedIcon: e.selectedIcon,
                  label: Text(e.label),
                ),
              )
              .toList(),
          selectedIndex: _selectedIndex,
          trailing: Expanded(
            child: Column(
              mainAxisAlignment: .end,
              children: widget.actions(isNavigationRail: true),
            ),
          ),
        ),
        Expanded(child: body),
      ],
    );
  }

  Widget? _buildFloatingActionButton() {
    final floatingActionButtonBuilder = widget.floatingActionButtonBuilder;
    if (floatingActionButtonBuilder == null) {
      return null;
    }

    final child = floatingActionButtonBuilder.call(context, _selectedIndex);
    if (child == null) {
      return null;
    }

    return child;
  }

  Widget? _buildBottomNavigationBar(bool useNavigationRail) {
    if (useNavigationRail) {
      return null;
    }
    return NavigationBar(
      onDestinationSelected: (value) => setState(() => _selectedIndex = value),
      selectedIndex: _selectedIndex,
      destinations: widget.navigationItems
          .map(
            (e) => NavigationDestination(
              icon: e.unselectedIcon,
              selectedIcon: e.selectedIcon,
              label: e.label,
              tooltip: e.tooltip,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final useNavigationRail = MediaQuery.sizeOf(context).width > 520;

    final appBarActions = useNavigationRail
        ? <Widget>[]
        : widget.actions(isNavigationRail: false);
    return Scaffold(
      appBar:
          widget.appBar?.call(
            appBarActions,
            isNavigationRail: useNavigationRail,
          ) ??
          (useNavigationRail ? null : AppBar(actions: appBarActions)),
      body: _buildBody(useNavigationRail),
      bottomNavigationBar: _buildBottomNavigationBar(useNavigationRail),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
