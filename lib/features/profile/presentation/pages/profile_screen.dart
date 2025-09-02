import 'package:breach/core/core.dart';
import 'package:breach/core/local_data/user_data/secured_user_data.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart';
import 'package:breach/features/profile/profile.dart';


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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
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

                        InterestSection(
                          userInterestsCubit:userInterestsCubit,
                        ),
                        const Spacer(),
                        ClickableWidget(
                          onTap: (){
                            showDialog<void>(
                              context: context,
                              builder: (context){
                                return const LogoutConfirmationDialog();
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
            );
          },
        ),
      ),
    ),
);
  }
}
