import 'package:breach/core/core.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    this.enableScroll = true,
    super.key,
  });
  final bool enableScroll;


  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    if (enableScroll) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Shimmer(
            child: Card(
              color: AppColors.grey.withValues(alpha: 0.5),
              child: ListTile(
                title: const Text(''),
                subtitle: const Text(''),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.grey.withValues(alpha: 0.5),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return uiHelper.verticalSpace(10);
        },
      );
    } else {
      return ListView.separated(
            shrinkWrap: true,
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer(
                child: Card(
                  color: AppColors.grey.withValues(alpha: 0.5),
                  child: ListTile(
                    title: const Text(''),
                    subtitle: const Text(''),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.grey.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return uiHelper.verticalSpace(10);
            },
          );
    }
  }
}
