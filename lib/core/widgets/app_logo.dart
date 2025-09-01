import 'package:breach/core/core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.width = 80,
    this.height = 40,
    super.key,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return SvgPicture.asset(Assets.logo.svg,
      width: uiHelper.getMappedWidth(width),
      height: uiHelper.getMappedHeight(height)
      ,).animate(
        effects: [
          const ScaleEffect(
            end: Offset(1, 1),
            begin: Offset.zero,
          ),
        ],
    );
  }
}
