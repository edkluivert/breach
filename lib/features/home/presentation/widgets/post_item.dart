import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    required this.blogEntity,
    super.key,
  });

  final BlogEntity blogEntity;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 200,
              child: FastCachedImage(
                url: blogEntity.imageUrl ?? '',
                fit: BoxFit.cover,
                fadeInDuration: const Duration(seconds: 1),
                errorBuilder: (context, exception, stacktrace) {
                  return Center(
                    child: Text(
                      'Error loading image',
                      style: context.textThemeC.bodySmall14Regular?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, progress) {
                  return ColoredBox(
                    color: AppColors.secondaryPrimaryColor,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (progress.isDownloading && progress.totalBytes != null)
                          Text(
                            '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
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
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogEntity.series!.name ?? 'N/A',
                  style: context.textThemeC.bodySmall14Regular?.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
                uiHelper.verticalSpace(8),
                Text(
                  blogEntity.title ?? 'N/A',
                  style: context.textThemeC.bodySmall14Regular?.copyWith(
                    color: AppColors.grey600,
                    fontSize: 16,
                  ),
                ),
                uiHelper.verticalSpace(4),
                Text(
                  blogEntity.content ?? 'N/A',
                  style: context.textThemeC.bodySmall14Regular?.copyWith(
                    color: AppColors.grey600,
                    fontSize: 16,
                  ),
                ),
                uiHelper.verticalSpace(4),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      blogEntity.author!.name ?? 'N/A',
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
                      blogEntity.createdAt!.toFormattedDate(),
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
    );
  }
}
