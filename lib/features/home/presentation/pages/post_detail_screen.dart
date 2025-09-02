
import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({required this.post, super.key});

  final BlogEntity post;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: context.width,
                  height: context.height,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: post.imageUrl ?? '',
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      progressIndicatorBuilder: (context,url, progress) {
                        return ColoredBox(
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
                        return const Center(child: Icon(Icons.error));
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: SafeArea(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 5, width: 35, color: Colors.black12),
                      ],
                    ),
                  ),

                  Text(
                    post.title ?? 'Untitled Post',
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  uiHelper.verticalSpace(10),
                  Text(
                    "${post.category?.name ?? 'General'} • ${post.createdAt!.toFormattedDate()}",
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  uiHelper.verticalSpace(10),
                  Text(
                    post.author?.name ?? 'Unknown Author',
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(height: 4, color: AppColors.divider),
                  ),
                  Text(
                    post.content ??
                        'No description available for this post yet.',
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
