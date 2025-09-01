import 'package:breach/core/core.dart';
import 'package:breach/core/local_data/first_time_user/save_first_time.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/features.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> with SingleTickerProviderStateMixin {

  late GifController _controller;
  late SaveFirstTime saveFirstTime;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
     saveFirstTime = sl<SaveFirstTime>();
  }


  @override
  void dispose() {
    _controller..stop()
    ..dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    final navigationService = sl<NavigationService>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gif(
                image: AssetImage(Assets.beaver.gif),
                controller: _controller,
                //fps: 30,
                //duration: const Duration(seconds: 3),

                repeat: ImageRepeat.repeat,
                autostart: Autostart.loop,
                placeholder: (context) => const CustomCircularProgressIndicator(),
                onFetchCompleted: () {
                  _controller..reset()
                    ..forward();
                },
              ),
              uiHelper.verticalSpace(10),
              RichText(
                  text: TextSpan(
                    text: 'Find',
                    style: context.textThemeC.subHeading?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                      color: AppColors.textColor,
                    ),
                    children: [
                      TextSpan(
                        text: ' Great ',
                        style: context.textThemeC.subHeading?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 34,
                          color: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Ideas',
                        style: context.textThemeC.subHeading?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 34,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
              ),
              uiHelper.verticalSpace(18),
              Text(
                AppStrings.getStartedSubtitle,
                style: context.textThemeC.bodySmall14Regular?.copyWith(
                  color: AppColors.textColor,
                  fontSize: 18,
                ),
              ),
              uiHelper.verticalSpace(30),
              SizedBox(
                width: context.width/2,
                child: BusyButton(
                  title: AppStrings.joinBreach,
                  onPressed: (){
                    saveFirstTime.call('Saved');
                    navigationService.removeAllAndNavigateTo(Routes.signup);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
