import 'package:breach/core/core.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:breach/features/home/presentation/state_management/category/categories_cubit.dart';
import 'package:breach/features/home/presentation/state_management/save_interests/save_interests_cubit.dart';
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart';
import 'package:breach/features/home/presentation/widgets/better_experience_pop_up.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({required this.onResult, super.key});
  final VoidCallback onResult;

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late final CategoriesCubit categoriesCubit;
  late final SaveInterestsCubit saveInterestsCubit;
  late final UserInterestsCubit userInterestsCubit;

  @override
  void initState() {
    super.initState();
     categoriesCubit = sl<CategoriesCubit>();
    saveInterestsCubit = SaveInterestsCubit(sl<HomeUseCase>());
    userInterestsCubit = sl<UserInterestsCubit>();

      categoriesCubit.loadCategories();

    userInterestsCubit.loadUserInterests();
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    final navigationService = sl<NavigationService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: categoriesCubit),
        BlocProvider.value(value: saveInterestsCubit),
        BlocProvider.value(value: userInterestsCubit),
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

                  BlocBuilder<UserInterestsCubit, UserInterestsState>(
                    builder: (context, userState) {
                      final preselectedIds = <String>[];
                      if (userState is UserInterestsLoaded) {
                        preselectedIds.addAll(
                          userState.interests
                              .map((e) => e.category!.id.toString())
                              .toList(),
                        );
                      }
                      return BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, state) {
                          if (state is CategoriesLoading) {
                            return const CustomCircularProgressIndicator();
                          } else if (state is CategoriesLoaded) {
                            final categories = state.categories;
                            return BlocBuilder<
                              SaveInterestsCubit,
                              SaveInterestsState
                            >(
                              builder: (context, saveState) {
                                final selectedIds = <dynamic>{
                                  ...preselectedIds,
                                  if (saveState
                                      is SaveInterestsSelectionChanged)
                                    ...saveState.selectedIds,
                                }.toList();

                                return Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: categories.map<Widget>((cat) {
                                    final isSelected = selectedIds.contains(
                                      cat.id.toString(),
                                    );
                                    return FilterChip(
                                      avatar: Text(
                                        cat.icon ?? '',
                                        style: context
                                            .textThemeC
                                            .bodyNormal16Bold
                                            ?.copyWith(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.textColor,
                                              fontSize: 14,
                                            ),
                                      ),
                                      label: Text(
                                        cat.name ?? '',
                                        style: context
                                            .textThemeC
                                            .bodyNormal16Bold
                                            ?.copyWith(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.textColor,
                                              fontSize: 14,
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
                                      selectedColor:
                                          AppColors.secondaryPrimaryColor,
                                      selected: isSelected,
                                      backgroundColor: AppColors.white,
                                      onSelected: (_) {
                                        context
                                            .read<SaveInterestsCubit>()
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
                      );
                    },
                  ),

                  uiHelper.verticalSpace(60),

                  SizedBox(
                    width: context.width / 3,
                    child: BlocConsumer<SaveInterestsCubit, SaveInterestsState>(
                      listener: (context, state) {
                        if (state is SaveInterestsSuccess) {
                          widget.onResult();
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is SaveInterestsLoading;
                        final itemSelected =
                            state is SaveInterestsSelectionChanged;
                        return BusyButton(
                          title: AppStrings.next,
                          color: AppColors.textColor,
                          busy: isLoading,
                          onPressed: itemSelected
                              ? () {
                                  context
                                      .read<SaveInterestsCubit>()
                                      .saveInterests();
                                }
                              : null,
                        );
                      },
                    ),
                  ),

                  uiHelper.verticalSpace(20),

                  BlocBuilder<SaveInterestsCubit, SaveInterestsState>(
                    builder: (context, state) {
                      return ClickableWidget(
                        onTap: () async {
                          if (state is SaveInterestsSelectionChanged &&
                              state.selectedIds.isEmpty) {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const BetterExperienceDialog(),
                            );
                          }
                        },
                        child: Text(
                          AppStrings.skip,
                          style: context.textThemeC.bodySmall14Regular
                              ?.copyWith(
                                fontSize: 14,
                                color: AppColors.textColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
