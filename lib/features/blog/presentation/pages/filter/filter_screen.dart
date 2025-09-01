import 'package:breach/core/core.dart';
import 'package:breach/core/extensions/other_extensions.dart';
import 'package:breach/core/widgets/app_error_widget.dart';
import 'package:breach/features/blog/presentation/state_management/filter/filter_cubit.dart';
import 'package:breach/features/blog/presentation/state_management/filter/filter_state.dart';
import 'package:breach/features/home/presentation/state_management/category/categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    required this.onFetch,
    super.key,});

  final void Function(String selectedCategoryId) onFetch;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  late CategoriesCubit categoriesCubit;
  late FilterCubit filterCubit;

  @override
  void initState() {
    super.initState();
    categoriesCubit = sl<CategoriesCubit>();
    filterCubit = sl<FilterCubit>();
    if (categoriesCubit.state is! CategoriesLoaded) {
      categoriesCubit.loadCategories();
    }

  }


  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: filterCubit,
        ),
        BlocProvider.value(
          value: categoriesCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.selectCategory,
           style: context.textThemeC.bodyNormal16Bold?.copyWith(
             color: AppColors.textColor,
           ),
        )),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: CustomCircularProgressIndicator());
                    } else if (state is CategoriesLoaded) {
                      final categories = state.categories;

                      return BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, choiceState) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: categories.map((cat) {
                              final isSelected = choiceState.selectedId ==
                                  cat.id.toString();
                              return ChoiceChip(
                                avatar: Text(
                                  cat.icon ?? '',
                                  style: context.textThemeC.bodyNormal16Bold
                                      ?.copyWith(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                label: Text(
                                  cat.name ?? '',
                                  style: context.textThemeC.bodyNormal16Bold
                                      ?.copyWith(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                selected: isSelected,
                                backgroundColor: AppColors.white,
                                selectedColor: AppColors.secondaryPrimaryColor,
                                onSelected: (_) {
                                  context.read<FilterCubit>().select(
                                      cat.id.toString());
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

                uiHelper.verticalSpace(20),

                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    return Center(
                      child: SizedBox(
                        width: context.width/3,
                        child: BusyButton(
                          title: AppStrings.filterBy,
                          color: AppColors.textColor,
                          onPressed: state.selectedId != null
                              ? () => widget.onFetch(state.selectedId!)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                uiHelper.verticalSpace(100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
