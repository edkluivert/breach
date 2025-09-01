import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/features.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: AppLogo()),
    );
  }
}
