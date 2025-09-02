import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/core/widgets/loading_shimmer.dart';
import 'package:breach/features/blog/presentation/widgets/empty_posts.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/state_management/post/posts_cubit.dart';
import 'package:breach/features/home/presentation/widgets/home_app_bar.dart';
import 'package:breach/features/home/presentation/widgets/post_banner.dart';
import 'package:breach/features/home/presentation/widgets/post_item.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostsCubit postsCubit;

  @override
  void initState() {
    super.initState();
    postsCubit = sl<PostsCubit>();
    postsCubit.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return BlocProvider.value(
      value: postsCubit,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return ListView(
                    children: [
                      Shimmer(
                        child: Container(
                          height: 300,
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.grey.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      uiHelper.verticalSpace(20),
                      const LoadingShimmer(),
                    ],
                  );
                }

                if (state is PostsError) {
                  return AppErrorWidget(
                    title: state.message,
                    onTap: () => postsCubit.loadPosts(),
                  );
                }

                if (state is PostsLoaded) {
                  final posts = state.posts;

                  if (posts.isEmpty) {
                    return EmptyPosts(postsCubit: postsCubit);
                  }

                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      await postsCubit.loadPosts();
                    },
                    child: ListView(
                      children: [
                        PostBanner(blogEntity: posts.first),
                        uiHelper.verticalSpace(20),
                        Text(
                          AppStrings.recent,
                          style: context.textThemeC.bodySmall14Regular
                              ?.copyWith(
                                fontSize: 16,
                                fontFamily: Fonts.spaceGrotesk,
                                color: AppColors.textColor,
                              ),
                        ),
                        uiHelper.verticalSpace(8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: posts.length - 1,
                          itemBuilder: (context, index) {
                            final post = posts[index + 1];
                            return PostItem(blogEntity: post);
                          },
                          separatorBuilder: (context, index) =>
                              uiHelper.verticalSpace(14),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
