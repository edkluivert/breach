import 'package:breach/core/core.dart';

class AppTheme {
  static ThemeData createLightThemeData() {
    final theme = ThemeData.light();
    final textTheme = theme.textTheme.copyWith(
      displayLarge: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      displayMedium: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      displaySmall: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      headlineMedium: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      headlineSmall: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      titleLarge: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      labelLarge: const TextStyle(
        fontFamily: Fonts.inter,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
    );

    return theme.copyWith(
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: textTheme.displaySmall,
        surfaceTintColor: AppColors.white,
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        toolbarTextStyle: textTheme.bodyNormal16Regular!.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
      primaryIconTheme: theme.iconTheme.copyWith(
        color: AppColors.primaryColor,
      ),
      bottomSheetTheme: theme.bottomSheetTheme.copyWith(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        backgroundColor: AppColors.primaryColor.withOpacity(0.4),
        modalBackgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textColor,
        selectedLabelStyle: theme.textTheme.bodySmall14Bold?.copyWith(
          color: AppColors.primaryColor,
        ),
        unselectedLabelStyle: theme.textTheme.bodySmall14Bold?.copyWith(
          color: AppColors.textColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme.labelLarge,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryColor;
            }
            return const Color(0xFFFAFBFF);
          },
        ),
        checkColor: WidgetStateProperty.all(
          const Color(0xFFFFFFFF),
        ),
        side: WidgetStateBorderSide.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              );
            }
            return const BorderSide(
              color: AppColors.greyDark,
            );
          },
        ),
        visualDensity: VisualDensity.compact,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        disabledBorder: outlineInputBorder(),
        hintStyle: textTheme.inputFieldValue?.copyWith(
          color: AppColors.textColor,
        ),
      ),
      colorScheme: theme.colorScheme
          .copyWith(
        primary: AppColors.secondaryPrimaryColor,
        surface: AppColors.secondaryPrimaryColor,
        onSurface: AppColors.white,
          )
          .copyWith(surface: AppColors.backgroundColor),
    );
  }

  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color(0xffC8D4EA),
        width: 0.5,
      ),
    );
  }
}
