import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/core/widgets/loading_shimmer.dart';
import 'package:breach/features/blog/presentation/widgets/empty_posts.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/state_management/post/posts_cubit.dart';
import 'package:breach/features/home/presentation/widgets/post_item.dart';

class PopularView extends StatefulWidget {
  const PopularView({
    required this.postsCubit,
    super.key,
  });

  final PostsCubit postsCubit;

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if(state is PostsLoading){
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: LoadingShimmer(),
          );
        }else if(state is PostsError){
          return AppErrorWidget(
            onTap: widget.postsCubit.loadPosts,
          );
        }else if(state is PostsLoaded){
          if(state.posts.isEmpty){
            return EmptyPosts(postsCubit: widget.postsCubit);
          }
          return RefreshIndicator.adaptive(
            onRefresh: ()async{
              await widget.postsCubit.loadPosts();
            },
            child: ListView.separated(
              itemCount: state.posts.length,
              padding: const EdgeInsets.only(
                left: kDefaultPadding, right: kDefaultPadding,
                top: 10,
              ),
              itemBuilder: (context, index) {
                return PostItem(
                  blogEntity: state.posts[index],
                );
              },
              separatorBuilder: (context, index) {
                return uiHelper.verticalSpace(10);
              },
            ),
          );
        }else{
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
