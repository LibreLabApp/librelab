import 'package:material_ui/material_ui.dart';

class const ButtonLoadingIndicator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox.square(
    dimension: 18,
    child: CircularProgressIndicator(strokeWidth: 2),
  );
}
