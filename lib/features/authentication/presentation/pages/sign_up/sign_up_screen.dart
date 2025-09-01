import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_logo.dart';
import 'package:breach/features/authentication/domain/use_cases/auth_use_case.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_formz.dart';
import 'package:breach/features/authentication/presentation/state_management/sign_up/sign_up_bloc.dart';
import 'package:breach/features/features.dart';
import 'package:formz/formz.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final NavigationService navigationService = sl<NavigationService>();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return BlocProvider(
     create: (context) => SignUpBloc(sl<AuthUseCase>()),
    child: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.status.isFailure) {
                FlushBarNotification.showError(
                  context: context,
                  message: state.errorMessage ?? 'Login failed',
                );
                return;
              }

              if (!state.status.isSuccess) return;
              navigationService.removeAllAndNavigateTo(Routes.welcome);
            },
            builder: (context, state) {
              return AutofillGroup(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      uiHelper.verticalSpace(20),
                      const AppLogo(),
                      uiHelper.verticalSpace(30),
                      Text(AppStrings.joinBreach,
                        style: context.textThemeC.subHeading?.copyWith(
                          color: AppColors.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      uiHelper.verticalSpace(10),
                      Text(AppStrings.signUpSubtitle,
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
                         initialValue: state.email.value,
                         nextFocusNode: passwordFocusNode,
                         autofillHints: const [
                           AutofillHints.username,
                           AutofillHints.email,
                         ],
                         onChanged: (value) => context
                             .read<SignUpBloc>()
                             .add(SignUpEmailChanged(value)),
                         validationMessage: state.email.displayError != null
                             ? 'Invalid email'
                             : null,
                      ),
                      uiHelper.verticalSpace(18),
                      InputField(
                        labelText: AppStrings.password,
                        placeholder: AppStrings.passwordPrompt,
                        password: true,
                        initialValue: state.password.value,
                        fieldFocusNode: passwordFocusNode,
                        nextFocusNode: confirmPasswordFocusNode,
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        onChanged: (value) => context
                            .read<SignUpBloc>()
                            .add(SignUpPasswordChanged(value)),
                        validationMessage: state.password.displayError?.text(),
                      ),
                      uiHelper.verticalSpace(18),
                      InputField(
                        labelText: AppStrings.confirmPassword,
                        placeholder: AppStrings.confirmPasswordPrompt,
                        password: true,
                        initialValue: state.confirmPassword.value,
                        fieldFocusNode: confirmPasswordFocusNode,
                        onChanged: (value) => context
                            .read<SignUpBloc>()
                            .add(SignUpConfirmPasswordChanged(value)),
                        validationMessage: state.confirmPassword.displayError?.text(),
                      ),
                      uiHelper.verticalSpace(30),
                      BusyButton(
                        title: AppStrings.continueText,
                        busy:
                        state.status == FormzSubmissionStatus.inProgress,
                        onPressed: state.isValid
                            ? () => context.read<SignUpBloc>().add(
                          const SignUpFormSubmitted(
                          ),
                        ) : null,
                      ),
                      uiHelper.verticalSpace(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyAcct,
                            style: context.textThemeC.bodySmall14Regular
                                ?.copyWith(
                              fontSize: 14,
                              color: AppColors.textColor,
                            ),
                          ),
                          ClickableWidget(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.login);
                            },
                            child: Text(
                              AppStrings.logIn,
                              style: context.textThemeC.bodySmall14Regular
                                  ?.copyWith(
                                fontSize: 14,
                                color: AppColors.textColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          AppStrings.bySigning,
                          style: context.textThemeC.bodySmall14Regular?.copyWith(
                            fontFamily: Fonts.spaceGrotesk,
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),),
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
