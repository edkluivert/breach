import 'package:breach/core/core.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    required this.title,
    super.key,});

  final String title;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      surfaceTintColor: AppColors.white,
      title: Text(
        title,
        style: theme.bodySmall?.copyWith(
          fontSize: 16,
          color: AppColors.blackv2,
          height: 16,
          letterSpacing: 0.5,
        ),
      ),
      leadingWidth: 60,
      leading: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: AppColors.grey600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
