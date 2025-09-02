import 'package:breach/core/core.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PostBanner extends StatelessWidget {
  const PostBanner({
    required this.blogEntity,
    super.key,
  });

  final BlogEntity blogEntity;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return ClickableWidget(
      borderRadius: 16,
      onTap: (){
        Navigator.pushNamed(
            context,
            Routes.postDetail,
            arguments: blogEntity,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: blogEntity.imageUrl ?? '',
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              progressIndicatorBuilder: (context,url, progress) {
                return Container(
                  width: context.width,
                  height: context.height/3,
                  color: AppColors.secondaryPrimaryColor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (url.isEmpty && progress.totalSize != null)
                        Text(
                          '${progress.downloaded ~/ 1024} / ${progress.totalSize! ~/ 1024} kb',
                          style: context.textThemeC.bodySmall14Regular?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      const SizedBox(
                        width: 120,
                        height: 120,
                        child: CustomCircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              },
              errorWidget: (context, exception, stacktrace) {
                return const Center(
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          uiHelper.verticalSpace(14),
          Text(blogEntity.title??'N/A',
            style: context.textThemeC.heading?.copyWith(
              fontSize: 20,
            ),
          ),
          uiHelper.verticalSpace(8),
          Text(blogEntity.content??'N/A',
            style: context.textThemeC.bodySmall14Regular?.copyWith(
              color: AppColors.grey600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
