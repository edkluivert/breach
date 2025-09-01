import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/blog/presentation/pages/filter/filter_screen.dart';
import 'package:breach/features/blog/presentation/state_management/blog/tab_cubit.dart';
import 'package:breach/features/blog/presentation/state_management/stream/web_socket_cubit.dart';
import 'package:breach/features/blog/presentation/tab_views/featured_view.dart';
import 'package:breach/features/blog/presentation/tab_views/popular_view.dart';
import 'package:breach/features/blog/presentation/tab_views/stream_view.dart';
import 'package:breach/features/features.dart';

import 'package:breach/features/home/presentation/state_management/post/posts_cubit.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  late PostsCubit postsCubit;

  late WebSocketCubit webSocketCubit;

  late TabCubit tabCubit;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    postsCubit = sl<PostsCubit>();
    webSocketCubit = sl<WebSocketCubit>();
    tabCubit = TabCubit();
    webSocketCubit.connect();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tabCubit),
        BlocProvider.value(
          value: postsCubit,
        ),
        BlocProvider.value(
          value: webSocketCubit,
        ),
      ],
      child: BlocBuilder<TabCubit, TabState>(
        builder: (context, tabState) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 140,
              leading: const Padding(
                padding: EdgeInsets.only(left: 30),
                child: AppLogo(),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Column(
                  children: [
                    TabBar(
                        controller: tabController,
                        indicatorColor: AppColors.secondaryPrimaryColor,
                        tabAlignment: TabAlignment.fill,
                        dividerColor: Colors.transparent,
                        onTap: (v) {
                          tabCubit.updateIndex(v);
                        },
                        labelStyle: context.textThemeC.bodySmall14Regular
                            ?.copyWith(
                          color: AppColors.secondaryPrimaryColor,
                        ),
                        unselectedLabelStyle: context.textThemeC
                            .bodySmall14Regular
                            ?.copyWith(
                          color: AppColors.textColor,
                        ),
                        tabs: const [
                          Tab(
                            text: 'Featured',
                          ),
                          Tab(
                            text: 'Popular',
                          ),
                          Tab(
                            text: 'Streams',
                          )
                        ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: AppColors.secondaryPrimaryColor.withValues(
                            alpha: 0.4),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                if(tabState.selectedIndex != 2)
                  InkResponse(
                      onTap: () {

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
                      child: const Icon(Icons.filter_alt,
                          color: AppColors.textColor, size: 24)),
                uiHelper.horizontalSpace(20),
              ],
            ),
            body: TabBarView(
                controller: tabController,

                children: [
                  FeaturedView(
                    postsCubit: postsCubit,
                  ),
                  PopularView(
                    postsCubit: postsCubit,
                  ),
                  StreamView(
                    webSocketCubit: webSocketCubit,
                  ),
                ]),
          );
        },
      ),
    );
  }
}
