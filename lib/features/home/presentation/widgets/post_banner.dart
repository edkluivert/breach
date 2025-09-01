import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class PostBanner extends StatelessWidget {
  const PostBanner({
    required this.blogEntity,
    super.key,
  });

  final BlogEntity blogEntity;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FastCachedImage(
            url: blogEntity.imageUrl ?? '',
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
            loadingBuilder: (context, progress) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            },
            errorBuilder: (context, exception, stacktrace) {
              return const Center(
                child: Icon(Icons.error),
              );
            },
          ),
        ),
        uiHelper.verticalSpace(14),
        Text(blogEntity.title??'N/A',
          style: context.textThemeC.heading?.copyWith(

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
    );
  }
}
