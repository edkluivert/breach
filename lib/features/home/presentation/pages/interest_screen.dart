import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:breach/features/home/presentation/state_management/category/categories_cubit.dart';
import 'package:breach/features/home/presentation/state_management/pop_up/dismiss_pop_cubit.dart';
import 'package:breach/features/home/presentation/state_management/save_interests/save_interests_cubit.dart';
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart';
import 'package:breach/features/home/presentation/widgets/better_experience_pop_up.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({
    required this.onResult,
    required this.userProfile,
    super.key,
  });
  final VoidCallback onResult;
  final bool userProfile;

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late final CategoriesCubit categoriesCubit;
  late final SaveInterestsCubit saveInterestsCubit;
  late final UserInterestsCubit userInterestsCubit;
  late final DismissPopCubit dismissPopCubit;

  @override
  void initState() {
    super.initState();
    categoriesCubit = sl<CategoriesCubit>();
    userInterestsCubit = sl<UserInterestsCubit>();
    dismissPopCubit = DismissPopCubit();

    saveInterestsCubit = SaveInterestsCubit(sl<HomeUseCase>());

    categoriesCubit.loadCategories();

    userInterestsCubit.loadUserInterests();
  }

  @override
  void dispose() {
    saveInterestsCubit.close();
    dismissPopCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: categoriesCubit),
        BlocProvider.value(value: saveInterestsCubit),
        BlocProvider.value(value: userInterestsCubit),
        BlocProvider.value(value: dismissPopCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppStrings.selectCategory,
            style: context.textThemeC.bodyNormal16Bold?.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Image.asset(Assets.beaverDp.png, width: 100),
                  uiHelper.verticalSpace(12),
                  Text(
                    AppStrings.interestTitle,
                    style: context.textThemeC.bodyNormal16Bold?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  uiHelper.verticalSpace(8),
                  Text(
                    AppStrings.interestSubtitle,
                    style: context.textThemeC.bodySmall14Regular?.copyWith(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  uiHelper.verticalSpace(40),

                  BlocListener<UserInterestsCubit, UserInterestsState>(
                    listener: (context, state) {
                      if (state is UserInterestsLoaded) {
                        saveInterestsCubit.setInitialSelectedIds(
                          state.interests
                              .map((e) => e.category!.id.toString())
                              .toList(),
                        );
                      }
                    },
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const CustomCircularProgressIndicator();
                        } else if (state is CategoriesLoaded) {
                          final categories = state.categories;
                          return BlocBuilder<SaveInterestsCubit, SaveInterestsState>(
                            builder: (context, saveState) {
                              final selectedIds = saveInterestsCubit.selectedIds;

                              return Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: categories.map((cat) {
                                  final isSelected =
                                  selectedIds.contains(cat.id.toString());
                                  return FilterChip(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    labelPadding: const EdgeInsets.only(right: 4),
                                    avatar: Text(
                                      cat.icon ?? '',
                                      style: context.textThemeC.bodyNormal16Bold
                                          ?.copyWith(
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.textColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    label: Text(
                                      cat.name ?? '',
                                      style: context.textThemeC.bodyNormal16Bold
                                          ?.copyWith(
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.textColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    checkmarkColor: isSelected
                                        ? AppColors.white
                                        : AppColors.textColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: isSelected
                                            ? AppColors.secondaryPrimaryColor
                                            : AppColors.inputBorder,
                                      ),
                                    ),
                                    selectedColor: AppColors.secondaryPrimaryColor,
                                    selected: isSelected,
                                    backgroundColor: AppColors.white,
                                    onSelected: (_) {
                                      saveInterestsCubit
                                          .toggleInterest(cat.id.toString());
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          );
                        } else if (state is CategoriesError) {
                          return AppErrorWidget(
                            title: state.message,
                            onTap: categoriesCubit.loadCategories,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),

                  uiHelper.verticalSpace(60),

                  SizedBox(
                    width: context.width / 3,
                    child: BlocConsumer<SaveInterestsCubit, SaveInterestsState>(
                      listener: (context, state) {
                        if (state is SaveInterestsSuccess) {
                          userInterestsCubit.loadUserInterests();
                          widget.onResult();
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is SaveInterestsLoading;
                        final itemSelected = state is SaveInterestsSelectionChanged ||
                            saveInterestsCubit.selectedIds.isNotEmpty;

                        return BusyButton(
                          title: widget.userProfile
                              ? AppStrings.save
                              : AppStrings.next,
                          color: AppColors.textColor,
                          busy: isLoading,
                          onPressed: itemSelected
                              ? () => saveInterestsCubit.saveInterests()
                              : null,
                        );
                      },
                    ),
                  ),
                  uiHelper.verticalSpace(20),
                  if (!widget.userProfile) ...[

                    ClickableWidget(
                      onTap: handleSkip,
                      child: Text(
                        AppStrings.skip,
                        style: context.textThemeC.bodySmall14Regular?.copyWith(
                          fontSize: 14,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSkip() async {
    final navigationService = sl<NavigationService>();
    if (!dismissPopCubit.state) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const BetterExperienceDialog(),
      );
      dismissPopCubit.showDialogOnce();
    } else {
      await navigationService.removeAllAndNavigateTo(Routes.appBottomNav);
    }
  }
}
