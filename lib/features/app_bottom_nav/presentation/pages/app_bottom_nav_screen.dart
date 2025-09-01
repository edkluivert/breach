import 'package:breach/core/injections/injection.dart';
import 'package:breach/features/app_bottom_nav/presentation/state_management/app_bottom_nav_cubit.dart';
import 'package:breach/features/app_bottom_nav/presentation/state_management/bottom_nav_state.dart';
import 'package:breach/features/blog/presentation/pages/blog_screen.dart';
import 'package:breach/features/features.dart';
import 'package:breach/features/home/presentation/pages/home_screen.dart';
import 'package:breach/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppBottomNavScreen extends StatefulWidget {
  const AppBottomNavScreen({super.key});

  @override
  State<AppBottomNavScreen> createState() => _AppBottomNavScreenState();
}

class _AppBottomNavScreenState extends State<AppBottomNavScreen> {
  final appBottomNavCubit = sl<AppBottomNavCubit>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: appBottomNavCubit,
        ),
      ],
      child: BlocBuilder<AppBottomNavCubit, BottomNavState>(
        builder: (context, tabIndex) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (c, s) {
              if (tabIndex.index > 0) {
                context.read<AppBottomNavCubit>().changeTabIndex(0);
              }
            },
            child: Scaffold(
              body: IndexedStack(
                index: tabIndex.index,
                children: const [
                  HomeScreen(),
                  BlogScreen(),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: Material(
                elevation: 10,
                shadowColor: AppColors.lightPurple,
                child: BottomNavigationBar(
                  unselectedItemColor: AppColors.textColor,
                  selectedItemColor: AppColors.secondaryPrimaryColor,
                  unselectedLabelStyle: theme.bodySmaller12Regular?.copyWith(
                    color: AppColors.textColor,
                    fontSize: 12,
                  ),
                  selectedLabelStyle: theme.bodySmaller12Regular?.copyWith(
                    fontSize: 12,
                    color: AppColors.secondaryPrimaryColor,
                  ),
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.white,
                  elevation: 2,
                  currentIndex: tabIndex.index,
                  onTap: (index) {
                    context.read<AppBottomNavCubit>().changeTabIndex(index);
                    appBottomNavCubit.toggleWidth();
                  },
                  items: _buildNavigationItems(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  List<BottomNavigationBarItem> _buildNavigationItems() {
    return [
      _buildNavItem(
        activeIcon: Assets.home.svg,
        inactiveIcon: Assets.home.svg,
        label: AppStrings.home,
      ),
      _buildNavItem(
        activeIcon: Assets.blog.svg,
        inactiveIcon: Assets.blog.svg,
        label: AppStrings.blog,
      ),
      _buildNavItem(
        activeIcon: Assets.profile.svg,
        inactiveIcon: Assets.profile.svg,
        label: AppStrings.profile,
      ),
    ];
  }

  BottomNavigationBarItem _buildNavItem({
    required String activeIcon,
    required String inactiveIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      // For inactive state
      icon: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              inactiveIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.textColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      // For active state
      activeIcon: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -9,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                width: appBottomNavCubit.state.barWidth,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.secondaryPrimaryColor,
                ),
                duration: const Duration(milliseconds: 400),
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset(
              activeIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.secondaryPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      label: label,
    );
  }
}
