import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';

class StreamItem extends StatelessWidget {
  const StreamItem({
    required this.blogEntity,
    super.key,
  });

  final BlogEntity blogEntity;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return SizedBox(
      width: context.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(blogEntity.title??'N/A',
            style: context.textThemeC.heading?.copyWith(
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
          uiHelper.verticalSpace(4),
          Text(blogEntity.content??'N/A',
            style: context.textThemeC.bodySmall14Regular?.copyWith(
              color: AppColors.grey600,
              fontSize: 16,
            ),
          ),
          uiHelper.verticalSpace(4),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(blogEntity.author!.name??'N/A',
                style: context.textThemeC.bodySmall14Regular?.copyWith(
                  color: AppColors.textColor,
                  fontSize: 11,
                ),
              ),
              const Icon(Icons.circle,
                color: AppColors.textColor,
                size: 8,
              ),
              Text(blogEntity.createdAt!.toFormattedDate(),
                style: context.textThemeC.bodySmall14Regular?.copyWith(
                  color: AppColors.textColor,
                  fontSize: 11,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
