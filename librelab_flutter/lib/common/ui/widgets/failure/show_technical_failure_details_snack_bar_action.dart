import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/technical_failure_details_dialog.dart';
import 'package:material_ui/material_ui.dart';

class ShowTechnicalFailureDetailsSnackBarAction extends SnackBarAction {
  new({
    super.key,
    required BuildContext context,
    required String failureDetails,
  }) : super(
         label: context.t.technicalFailureDetails.showDialog,
         onPressed: () => TechnicalFailureDetailsDialog.show(
           context,
           details: failureDetails,
         ),
       );
}
