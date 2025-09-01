import 'package:breach/core/core.dart';
import 'package:breach/core/local_data/user_data/secured_user_data.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/pages/interest_screen.dart';
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart';
import 'package:breach/features/profile/presentation/widgets/log_out_confirmation_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserInterestsCubit userInterestsCubit;

  late SecuredUserData securedUserData;
  SecuredUser? securedUser;

  @override
  void initState() {
    super.initState();
    userInterestsCubit = sl<UserInterestsCubit>();
    securedUserData = sl<SecuredUserData>();
    userInterestsCubit.loadUserInterests();

    getUserInfo();
  }


  Future<void> getUserInfo() async {
    final user = await securedUserData.getUserData();
    if (mounted) {
      setState(() {
        securedUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return BlocProvider.value(
  value: userInterestsCubit,
  child: Scaffold(
      appBar: AppBar(
        leadingWidth: 140,
        leading: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: AppLogo(),
        ),
        actions: [
          Image.asset(
            Assets.beaverDp.png,
            width: 40,
          ),
          uiHelper.horizontalSpace(20),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(Assets.beaverDp.png),
                ),
                uiHelper.verticalSpace(12),
                if(securedUser != null)
                Text(
                  securedUser!.name??'N/A',
                  style: context.textThemeC.bodyNormal16Bold?.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                if(securedUser != null)
                Text(
                  securedUser!.email??'N/A',
                  style: context.textThemeC.bodyNormal16Bold?.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
                uiHelper.verticalSpace(12),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                  textAlign: TextAlign.center,
                  style: context.textThemeC.bodyNormal16Bold?.copyWith(
                    color: AppColors.grey600,
                    fontFamily: Fonts.spaceGrotesk,
                    height: 1.4,
                  ),
                ),
                uiHelper.verticalSpace(30),
            
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
            
                BlocBuilder<UserInterestsCubit, UserInterestsState>(
                  builder: (context, state) {
                    if (state is UserInterestsLoading) {
                      return const CustomCircularProgressIndicator();
                    } else if (state is UserInterestsLoaded) {
                      final interests = state.interests;
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: interests.map((interest) {
                          return Chip(
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
                uiHelper.verticalSpace(40),
                ClickableWidget(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return LogoutConfirmationDialog();
                        },
                    );
                  },
                  child: Text(
                    'Click to log out',
                    style: context.textThemeC.bodyNormal16Bold?.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ),
                uiHelper.verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
