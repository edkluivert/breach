

import 'package:breach/core/core.dart';
import 'package:breach/features/features.dart';

class BetterExperienceDialog extends StatelessWidget {
  const BetterExperienceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    final navigationService = sl<NavigationService>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: context.width * 0.85,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Personalize Your Experience',
              style: context.textThemeC.bodyNormal16Bold?.copyWith(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Selecting some categories will help us recommend better content '
                  'and make your experience more enjoyable.',
              textAlign: TextAlign.center,
              style: context.textThemeC.bodySmall14Regular?.copyWith(
                color: AppColors.grey600,
              ),
            ),
            uiHelper.verticalSpace(20),
            BusyButton(
              onPressed: navigationService.pop,
              title: 'Got it',
            ),
          ],
        ),
      ),
    );
  }
}

