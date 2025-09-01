import 'package:breach/core/core.dart';
import 'package:breach/features/blog/presentation/pages/filter/filter_screen.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/state_management/post/posts_cubit.dart';

class EmptyPosts extends StatelessWidget {
  const EmptyPosts({
    required this.postsCubit,
    super.key,
  });

  final PostsCubit postsCubit;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uiHelper.verticalSpace(20),
          Text('No posts at the moment',
            style: context.textThemeC.bodyNormal16Bold?.copyWith(
              color: AppColors.textColor,
            ),
          ),
          uiHelper.verticalSpace(20),
          SizedBox(
            width: context.width/2,
            child: BusyButton(
              title: 'Try a different category',
              color: AppColors.textColor,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilterScreen(
                          onFetch: (value) {
                            Navigator.pop(context);
                            postsCubit.loadPosts(category: value);
                          },
                        ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
