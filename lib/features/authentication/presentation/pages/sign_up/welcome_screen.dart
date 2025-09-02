import 'package:breach/core/core.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/pages/interest_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    final navigationService = sl<NavigationService>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.beaver.png,

              ),
              uiHelper.verticalSpace(30),
              Text(AppStrings.welcome,
                style: context.textThemeC.bodyNormal16Bold?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 34,
                  color: AppColors.textColor,
                ),
              ),
              uiHelper.verticalSpace(10),
              Text(AppStrings.welcomeSubtitle,
                style: context.textThemeC.bodySmall14Regular?.copyWith(
                  fontSize: 14,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              uiHelper.verticalSpace(40),
              SizedBox(
                width: context.width/3,
                child: BusyButton(
                  title: AppStrings.letsBegin,
                  color: AppColors.textColor,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InterestScreen(
                          userProfile: false,
                          onResult: ()=>navigationService.
                          removeAllAndNavigateTo(Routes.appBottomNav),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
