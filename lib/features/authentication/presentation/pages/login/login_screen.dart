import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/authentication/domain/use_cases/auth_use_case.dart';
import 'package:breach/features/authentication/presentation/state_management/login/login_bloc.dart';
import 'package:breach/features/features.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final NavigationService navigationService = sl<NavigationService>();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return BlocProvider(
      create: (context) => LoginBloc(sl<AuthUseCase>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status.isFailure) {
                  FlushBarNotification.showError(
                    context: context,
                    message: state.errorMessage ?? 'Login failed',
                  );
                  return;
                }

                if (!state.status.isSuccess) return;
                navigationService.removeAllAndNavigateTo(Routes.appBottomNav);
              },
              builder: (context, state) {
                return AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      uiHelper.verticalSpace(20),
                      const AppLogo(),
                      uiHelper.verticalSpace(30),
                      Text(
                        AppStrings.joinBreach,
                        style: context.textThemeC.subHeading?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      uiHelper.verticalSpace(10),
                      Text(
                        AppStrings.signUpSubtitle,
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                      uiHelper.verticalSpace(20),
                      InputField(
                        labelText: AppStrings.email,
                        placeholder: AppStrings.emailPrompt,
                        fieldFocusNode: emailFocusNode,
                        autofillHints: const [
                          AutofillHints.username,
                          AutofillHints.email,
                        ],
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(LoginEmailChanged(value)),
                        validationMessage: state.email.displayError != null
                            ? 'Invalid email'
                            : null,
                      ),
                      uiHelper.verticalSpace(18),
                      InputField(
                        labelText: AppStrings.password,
                        placeholder: AppStrings.passwordPrompt,
                        password: true,
                        fieldFocusNode: passwordFocusNode,
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(LoginPasswordChanged(value)),
                        validationMessage: state.password.displayError != null
                            ? 'Invalid password'
                            : null,
                      ),
                      uiHelper.verticalSpace(10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ClickableWidget(
                          onTap: () {
                            FlushBarNotification.showInfoMessage(
                              context: context,
                              message: 'Feature is currently unavailable',
                              title: 'Dear User',
                            );
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: context.textThemeC.bodySmall14Regular
                                ?.copyWith(color: AppColors.textColor),
                          ),
                        ),
                      ),
                      uiHelper.verticalSpace(30),
                      BusyButton(
                        title: AppStrings.continueText,
                        busy:
                        state.status == FormzSubmissionStatus.inProgress,
                        onPressed: state.isValid
                            ? () => context.read<LoginBloc>().add(
                          const LoginFormSubmitted(
                          ),
                        ) : null,
                      ),
                      uiHelper.verticalSpace(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.donHaveAcct,
                            style: context.textThemeC.bodySmall14Regular
                                ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textColor,
                                ),
                          ),
                          ClickableWidget(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.signup,
                                (route) => false,
                              );
                            },
                            child: Text(
                              AppStrings.joinBreach,
                              style: context.textThemeC.bodySmall14Regular
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: AppColors.textColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.textColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          AppStrings.bySigning,
                          style: context.textThemeC.bodySmall14Regular
                              ?.copyWith(
                                fontFamily: Fonts.spaceGrotesk,
                                fontSize: 14,
                                color: AppColors.textColor,
                              ),
                        ),
                      ),
                      Center(
                        child: Text(
                          AppStrings.tAndC,
                          style: context.textThemeC.bodyNormal16Bold?.copyWith(
                            fontSize: 14,
                            fontFamily: Fonts.spaceGrotesk,
                            color: AppColors.secondaryPrimaryColor,
                            decorationColor: AppColors.secondaryPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      uiHelper.verticalSpace(100),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
