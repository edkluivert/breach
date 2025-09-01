import 'package:breach/core/constants/colors.dart';
import 'package:breach/core/injections/injection.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/core/navigation/navigation_service.dart';
import 'package:breach/core/navigation/route_generator.dart';
import 'package:breach/core/navigation/route_paths.dart';
import 'package:breach/core/theme/app_theme.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_bloc.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_event.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_state.dart';
import 'package:breach/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorService = sl<NavigationService>();
    return BlocProvider(
      create: (context) =>
      AuthBloc(
          secureStorage: sl<FlutterSecureStorage>())
        ..add(AppStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is FirstTimer) {
            navigatorService.removeAllAndNavigateTo(Routes.getStarted);
          } else if (state is Authenticated) {
            AppLogger.w('Sending to app bottom nav');
            navigatorService.removeAllAndNavigateTo(Routes.appBottomNav);
          } else if (state is Unauthenticated) {
            AppLogger.d('Help me, Help me, Dem dey carry me go where i nor know');
            navigatorService.removeAllAndNavigateTo(Routes.login);
          } else {
            AppLogger.wtf('Not really sure');
            navigatorService.removeAllAndNavigateTo(Routes.login);
          }
        },
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.secondaryPrimaryColor,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: MaterialApp(
            title: 'Breach',
            theme: AppTheme.createLightThemeData(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: generateRoute,
            onUnknownRoute: generateRoute,
            home: const SplashScreen(),
            navigatorKey: navigatorService.navigationKey,
          ),
        ),
      ),
    );
  }
}
