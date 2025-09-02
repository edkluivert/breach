import 'package:breach/core/core.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PostItem extends StatelessWidget {
  const PostItem({
    required this.blogEntity,
    super.key,
  });

  final BlogEntity blogEntity;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return SizedBox(
      height: 200,
      child: ClickableWidget(
        borderRadius: 16,
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.postDetail,
            arguments: blogEntity,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 200,
                height: 200,
                child: CachedNetworkImage(
                  imageUrl: blogEntity.imageUrl ?? '',
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(seconds: 1),
                  errorWidget: (context, exception, stacktrace) {
                    return Center(
                      child: Text(
                        'Error loading image',
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    );
                  },
                  progressIndicatorBuilder: (context, url, progress) {
                    return const ColoredBox(
                      color: AppColors.secondaryPrimaryColor,
                      child: Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CustomCircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    blogEntity.series?.name ?? 'N/A',
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      color: AppColors.grey600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  uiHelper.verticalSpace(8),

                  Text(
                    blogEntity.title ?? 'N/A',
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      color: AppColors.grey600,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  uiHelper.verticalSpace(4),

                  Expanded(
                    child: Text(
                      blogEntity.content ?? 'N/A',
                      style: context.textThemeC.bodySmall14Regular?.copyWith(
                        color: AppColors.grey600,
                        fontSize: 12,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  uiHelper.verticalSpace(4),

                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        blogEntity.author?.name ?? 'N/A',
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 11,
                        ),
                      ),
                      const Icon(
                        Icons.circle,
                        color: AppColors.textColor,
                        size: 8,
                      ),
                      Text(
                        blogEntity.createdAt?.toFormattedDate() ?? '',
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

