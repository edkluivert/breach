import 'package:flutter/material.dart';
import 'package:breach/core/constants/colors.dart';
import 'package:breach/core/theme/fonts.dart';

extension TextThemeExtension on TextTheme {
  TextStyle? get heading {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
    );
  }

  TextStyle? get subHeading {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );
  }

  TextStyle? get bodyNormal16Regular {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textLight,
    );
  }

  TextStyle? get bodyNormal16Bold {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.greyDark,
    );
  }

  TextStyle? get smallButton {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    );
  }

  TextStyle? get bodySmall14Regular {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  TextStyle? get bodySmall14Bold {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );
  }

  TextStyle? get bodySmaller12Regular {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  TextStyle? get bodySmaller12Medium {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    );
  }

  TextStyle? get bodySmaller10Regular {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  TextStyle? get inputFieldLabel {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
    );
  }

  TextStyle? get inputFieldPassword {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    );
  }

  TextStyle? get inputFieldValue => bodySmall14Regular;

  TextStyle? get inputFieldHints {
    return const TextStyle(
      fontFamily: Fonts.inter,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    );
  }
}
