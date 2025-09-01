// ignore_for_file: avoid_multiple_declarations_per_line

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:breach/core/core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';




class BusyButton extends StatefulWidget {
  const BusyButton({
    required this.title,
    this.onPressed,
    this.busy = false,
    this.disabled = false,
    this.isSmall = false,
    this.color = AppColors.secondaryPrimaryColor,
    this.textColor = AppColors.white,
    this.enabled = true,
    this.outline = false,
    this.icon,
    this.borderRadius = 8,
    this.loaderColor = AppColors.loaderColor,
    this.disabledColor = AppColors.buttonDisabled,
    this.disabledTextColor = AppColors.textLight,
    this.height,
    this.buttonKey,
    this.width,
    super.key,
  });

  final bool busy;
  final String title;
  final VoidCallback? onPressed;
  final bool enabled, outline;
  final bool disabled;
  final Color color, textColor;
  final bool isSmall;
  final String? icon;
  final double borderRadius;
  final Color loaderColor;
  final double? height;
  final Key? buttonKey;
  final double? width;
  final Color? disabledColor;
  final Color? disabledTextColor;


  @override
  // ignore: library_private_types_in_public_api
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = widget.disabled || widget.onPressed == null
        ? widget.disabledTextColor ?? AppColors.white
        : widget.outline
        ? AppColors.secondaryPrimaryColor
        : widget.textColor;
    final buttonTheme = textTheme.labelLarge?.copyWith(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    final smallButtonTheme = textTheme.smallButton?.copyWith(
      color: textColor,
    );
    final height = widget.height ?? (widget.isSmall ? 36 : 50);

    return IgnorePointer(
      ignoring: widget.onPressed == null || widget.disabled,
      child: TouchableOpacity(
        buttonKey: widget.buttonKey,
        onTap: (widget.busy == false && widget.disabled == false) ? widget.onPressed : null,
        child: AnimatedContainer(
          height: height,
          width: widget.width,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: height,
            maxWidth: widget.width ?? UiHelper(context).screenSize.width,
          ),
          decoration: BoxDecoration(
            color: widget.disabled || widget.onPressed == null
                ? (widget.disabledColor ?? widget.color).withValues(alpha: 0.5)
                : widget.outline
                ? AppColors.white
                : widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.disabled || widget.onPressed == null
                  ? (widget.disabledColor ?? widget.color).withValues(alpha: 0.5)
                  : widget.outline
                  ? widget.color
                  : Colors.transparent,
            ),
          ),
          child: IgnorePointer(
            ignoring: widget.disabled || widget.onPressed == null,
            child: !widget.busy
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: widget.isSmall ? MainAxisSize.min : MainAxisSize.max,
              children: [
                if (widget.icon != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [SvgPicture.asset(widget.icon!), const Gap(10)],
                  ),
                SizedBox(
                  height: min(height * 0.5, 24),
                  child: Align(
                    child: AutoSizeText(
                      widget.title,
                      minFontSize: 9,
                      style: widget.isSmall ? smallButtonTheme : buttonTheme,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
                : ThirdPartyLoader(
              color: widget.outline ? widget.loaderColor : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

