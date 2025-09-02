import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/pages/interest_screen.dart';
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart';

class InterestSection extends StatelessWidget {
  const InterestSection({
    required this.userInterestsCubit,
    super.key,
  });

  final UserInterestsCubit userInterestsCubit;

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Interests',
              style: context.textThemeC.bodyNormal16Bold?.copyWith(
                color: AppColors.textColor,
              ),
            ),
            InkResponse(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterestScreen(
                      userProfile: true,
                      onResult: (){
                        Navigator.pop(context);
                        userInterestsCubit.loadUserInterests();
                      },
                    ),
                  ),
                );
              },
              child: const Icon(Icons.edit,
                color: AppColors.secondaryPrimaryColor,
              ),
            )
          ],
        ),
        uiHelper.verticalSpace(10),
        BlocBuilder<UserInterestsCubit, UserInterestsState>(
          builder: (context, state) {
            if (state is UserInterestsLoading) {
              return const Center(child: CustomCircularProgressIndicator());
            } else if (state is UserInterestsLoaded) {
              final interests = state.interests;
              if(interests.isEmpty){
                return Center(
                  child: Column(
                    children: [
                      uiHelper.verticalSpace(30),
                      Text('No interests, Click the edit icon to add some',
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                );
              }else{
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: interests.map((interest) {
                    return Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.only(right: 4),
                      avatar: Text(
                        interest.category!.icon ?? '',
                        style: context.textThemeC.bodyNormal16Bold
                            ?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                      label: Text(
                        interest.category!.name ?? '',
                        style: context.textThemeC.bodyNormal16Bold
                            ?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                      backgroundColor: AppColors.white,
                    );
                  }).toList(),
                );
              }
            } else if (state is UserInterestsError) {
              return AppErrorWidget(
                title: state.message,
                onTap: userInterestsCubit.loadUserInterests,
                spacing: 0,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        uiHelper.verticalSpace(20),
      ],
    );
  }
}
