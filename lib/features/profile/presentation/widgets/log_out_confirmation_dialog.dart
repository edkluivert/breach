import 'package:breach/core/core.dart';
import 'package:breach/features/app_bottom_nav/presentation/state_management/app_bottom_nav_cubit.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_bloc.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_event.dart';
import 'package:breach/features/features.dart';

class LogoutConfirmationDialog extends StatefulWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  State<LogoutConfirmationDialog> createState() => _LogoutConfirmationDialogState();
}

class _LogoutConfirmationDialogState extends State<LogoutConfirmationDialog> {
  late AppBottomNavCubit appBottomNavCubit;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = sl<AuthBloc>();
    appBottomNavCubit = sl<AppBottomNavCubit>();
  }

  @override
  Widget build(BuildContext context) {
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
              'Confirm Logout',
              style: context.textThemeC.bodyNormal16Bold?.copyWith(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to log out? You will need to log in again to access your account.',
              textAlign: TextAlign.center,
              style: context.textThemeC.bodySmall14Regular?.copyWith(
                color: AppColors.grey600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(
                  child: BusyButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: 'Cancel',
                    color: AppColors.buttonDisabled,
                  ),
                ),
                Expanded(
                  child: BusyButton(
                    onPressed: () {
                      appBottomNavCubit.reset();
                      authBloc.add(LogoutRequested());
                      navigationService.removeAllAndNavigateTo(Routes.login);
                    },
                    title: 'Logout',
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
