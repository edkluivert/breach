import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:breach/core/core.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    final canPop = Navigator.canPop(context);
    if (canPop || onTap != null) {
      return TouchableOpacity(
        onTap: onTap ?? () => Navigator.of(context).pop(),
        child: const Center(
          child: Icon(Icons.arrow_back_ios, color: AppColors.secondaryPrimaryColor),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
