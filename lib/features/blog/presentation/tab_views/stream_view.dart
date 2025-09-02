import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/core/widgets/loading_shimmer.dart';
import 'package:breach/features/blog/presentation/state_management/stream/web_socket_cubit.dart';
import 'package:breach/features/blog/presentation/state_management/stream/web_socket_state.dart';
import 'package:breach/features/blog/presentation/widgets/stream_item.dart';
import 'package:breach/features/features.dart';

class StreamView extends StatefulWidget {
  const StreamView({
    required this.webSocketCubit,
    super.key,
  });

  final WebSocketCubit webSocketCubit;

  @override
  State<StreamView> createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text('Streams',
            style: context.textThemeC.subHeading?.copyWith(
              color: AppColors.textColor,
              fontFamily: Fonts.spaceGrotesk,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text('Discover trending content from topics you care about in real time',
            style: context.textThemeC.bodySmall14Regular?.copyWith(
              color: AppColors.grey600,
              fontFamily: Fonts.spaceGrotesk,
            ),
          ),
        ),
        const Divider(
          indent: kDefaultPadding,
          endIndent: kDefaultPadding,
          color: AppColors.divider,
        ),
        BlocBuilder<WebSocketCubit, WebSocketState>(
          builder: (context, state) {
            if (state is WebSocketConnecting) {
              return const LoadingShimmer();
            } else if (state is WebSocketConnected) {
              return Center(
                child: Text('Listening for updates..',
                  style: context.textThemeC.bodySmall14Regular?.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              );
            }else if (state is WebSocketMessageList) {

              if(state.blogs.isEmpty){
                return Center(
                  child: Text(
                    'No updates at the moment',
                    style: context.textThemeC.bodyNormal16Bold?.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                );
              }
              return Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: ()async{
                    await widget.webSocketCubit.connect();
                  },
                  child: ListView.separated(
                    itemCount: state.blogs.length,
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding,
                      top: 10,
                    ),
                    itemBuilder: (context, index) {
                      return StreamItem(
                        blogEntity: state.blogs[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return uiHelper.verticalSpace(10);
                    },
                  ),
                ),
              );
            } else if (state is WebSocketError) {
              return AppErrorWidget(
                title: state.message,
                onTap: widget.webSocketCubit.connect,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );

  }

  @override
  bool get wantKeepAlive => true;
}
