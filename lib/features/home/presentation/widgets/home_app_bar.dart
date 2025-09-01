import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/features.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    this.bottom,
    super.key,
  });

  final PreferredSize? bottom;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return AppBar(
      leadingWidth: 140,
      leading: const Padding(
        padding: EdgeInsets.only(left: 30),
        child: AppLogo(),
      ),
      bottom: bottom,
      actions: [
        Image.asset(
          Assets.beaverDp.png,
          width: 40,
        ),
        uiHelper.horizontalSpace(20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
