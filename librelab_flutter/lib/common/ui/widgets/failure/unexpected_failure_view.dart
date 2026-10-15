import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/copy_code_block.dart';
import 'package:librelab_flutter/common/ui/widgets/illustrated_content.dart';
import 'package:librelab_flutter/common/ui/widgets/illustrations/unexpected_failure.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class const UnexpectedFailureView({
  super.key,
  required final Widget title,
  required final Widget subtitle,
  required final Widget? primaryButton,
  required final (Exception, StackTrace) exceptionWithStackTrace,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Center(
      child: SingleChildScrollView(
        child: IllustratedContent(
          title: title,
          subtitle: subtitle,
          illustration: const UnexpectedFailureIllustration(),
          titleSubtitleSpacing: 4,
          subtitleContentSpacing: 16,
          content: Column(
            spacing: 20,
            children: [
              Row(
                spacing: 8,
                children: [
                  ?primaryButton,
                  OutlinedButton.icon(
                    onPressed: () =>
                        launchUrl(Uri.parse(ProjectConstants.reportBugLink)),
                    label: Text(t.reportBug),
                    icon: const Icon(Icons.bug_report),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: CopyCodeBlock(
                    code:
                        'Exception: ${exceptionWithStackTrace.$1}\nStack Trace: ${exceptionWithStackTrace.$2}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
