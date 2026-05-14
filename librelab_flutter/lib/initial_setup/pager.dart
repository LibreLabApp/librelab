import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:librelab_flutter/initial_setup/steps/server_step.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialSetupPager extends StatefulWidget {
  const InitialSetupPager({super.key});

  @override
  State<InitialSetupPager> createState() => _InitialSetupPagerState();
}

class _InitialSetupPagerState extends State<InitialSetupPager> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _children = InitialSetupStep.values
      .map(
        (e) => switch (e) {
          // TODO: Replace
          .preferences => const Placeholder(),
          .server => const InitialSetupServerStep(),
          .account => const Placeholder(),
          .complete => const Placeholder(),
        },
      )
      .toList();

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void _onPageChanged(int index) {
    context.read<InitialSetupCubit>().setStep(
      InitialSetupStep.values.elementAt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        ConstrainedBox(
          // TODO: Dont hardcode (BoxConstraints)
          constraints: const BoxConstraints(maxHeight: 500),
          child: BlocListener<InitialSetupCubit, InitialSetupState>(
            listener: (context, state) =>
                _navigateToPage(state.currentStep.index),
            child: PageView(
              controller: _pageController,
              // IMPORTANT: Disable scrolling to prevent navigating freely
              // without completing previous steps.
              physics: const NeverScrollableScrollPhysics(),
              // If the above line was removed or removed,
              // please uncomment the bellow line to sync properly:
              // onPageChanged: _onPageChanged,
              children: _children,
            ),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            OutlinedButton(
              onPressed: () =>
                  context.read<InitialSetupCubit>().moveStep(forward: false),
              child: Text(context.t.initialSetupPage.back),
            ),
            BlocSelector<InitialSetupCubit, InitialSetupState, String?>(
              selector: (state) => state.nextButtonDisabledTooltip,
              builder: (context, tooltip) {
                final isDisabled = tooltip != null;
                return Tooltip(
                  message: isDisabled ? tooltip : '',
                  child: FilledButton.icon(
                    onPressed: isDisabled
                        ? null
                        : () => context.read<InitialSetupCubit>().moveStep(
                            forward: true,
                          ),
                    label: Text(context.t.initialSetupPage.next),
                    icon: const Icon(Icons.arrow_forward_outlined),
                    iconAlignment: IconAlignment.end,
                    style: FilledButton.styleFrom(
                      disabledBackgroundColor: colorScheme.onSurface.withValues(
                        alpha: 0.12,
                      ),
                      disabledForegroundColor: colorScheme.onSurface.withValues(
                        alpha: 0.38,
                      ),
                      disabledIconColor: colorScheme.onSurface.withValues(
                        alpha: 0.38,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: _children.length,
          effect: JumpingDotEffect(
            activeDotColor: context.theme.colorScheme.primary,
          ),
          onDotClicked: _onPageChanged,
        ),
      ],
    );
  }
}
