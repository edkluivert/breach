

import 'package:breach/core/core.dart';
import 'package:gap/gap.dart';

class AppErrorWidget extends StatefulWidget {
  const AppErrorWidget({
    this.title = 'Something went wrong',

    this.onTap,
    this.spacing = 50,
    this.icon,
    super.key,
  });

  final String title;
  final String? icon;
  final GestureTapCallback? onTap;
  final double spacing;

  @override
  State<AppErrorWidget> createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends State<AppErrorWidget> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final uiHelper = UiHelper(context);
    return SizedBox(
      child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54),
        child: Column(

          children: [
            uiHelper.verticalSpace(widget.spacing),
            SizedBox(
              height: 150,
              child: Image.asset(Assets.error.png),
            ),
            const Gap(24),
            Text(
              widget.title,
              style: theme.bodySmall14Regular?.copyWith(
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            BusyButton(
              title: 'Try again',
              onPressed: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}