import 'package:auto_size_text/auto_size_text.dart';
import 'package:breach/core/core.dart';
import 'package:breach/core/extensions/other_extensions.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.placeholder,
    super.key,
    this.controller,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.additionalNote,
    this.onChanged,
    this.inputFormatters,
    this.maxLines = 1,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.smallVersion = true,
    this.suffix,
    this.prefix,
    this.height,
    this.validationBorderColor,
    this.validationColor,
    this.validator,
    this.inputKey,
    this.readOnly = false,
    this.labelText,
    this.labelStyle,
    this.radius = 8,
    this.initialValue,
    this.autofillHints,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool password;
  final String placeholder;
  final String? validationMessage;
  final Function? enterPressed;
  final bool smallVersion;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? additionalNote;
  final String? initialValue;

  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final double? radius;
  final Widget? suffix;
  final Widget? prefix;
  final double? height;
  final Color? validationBorderColor;
  final Color? validationColor;
  final FormFieldValidator<String?>? validator;
  final Key? inputKey;
  final bool readOnly;
  final String? labelText;
  final TextStyle? labelStyle;
  final List<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  @override
  // ignore: library_private_types_in_public_api
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.password;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.labelText != null && widget.labelText!.isNotEmpty) ...[
          AutoSizeText(
            widget.labelText ?? '',
            style: widget.labelStyle ?? textTheme.bodySmaller12Regular?.copyWith(
              color: AppColors.textColor,
            ),
          ),
          const Gap(8),
        ],
        TextFormField(
          key: widget.inputKey,
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          focusNode: widget.fieldFocusNode,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          initialValue: widget.initialValue,
          autofillHints: widget.autofillHints,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: textTheme.inputFieldValue!.copyWith(
            color: AppColors.textColor,
          ),
          readOnly: widget.readOnly,
          cursorColor: AppColors.primaryColor,
          inputFormatters: widget.inputFormatters ?? [],

          onEditingComplete: () {
            if (widget.enterPressed != null) {
              FocusScope.of(context).requestFocus(FocusNode());
              // ignore: avoid_dynamic_calls
              widget.enterPressed?.call();
            }
          },
          cursorErrorColor: AppColors.secondaryPrimaryColor,
          obscureText: !isPasswordVisible && widget.password,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            isDense: true,

            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: widget.placeholder,
            hintStyle: context.textThemeC.bodySmall14Regular?.copyWith(
              color: AppColors.grey400,
              fontSize: 16,
            ),
            fillColor: Colors.transparent,
            filled: true,
            prefixIcon: Padding(
              padding:
                  widget.prefix == null ? const EdgeInsets.only(left: 8) :
                  const EdgeInsets.symmetric(horizontal: 8),
              child: widget.prefix,
            ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.password
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      }),
                      child: !isPasswordVisible
                          ? const Icon(
                              Icons.visibility_outlined,
                              size: 16,
                              color: AppColors.grey400,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              size: 16,
                              color: AppColors.grey400,
                            ),
                    ),
                  )
                : widget.suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: const BorderSide(
                color: AppColors.secondaryPrimaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: const BorderSide(
                color: AppColors.red,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
          onTapOutside: (event) {
            if (widget.fieldFocusNode != null) {
              widget.fieldFocusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
        ),
        if (widget.validationMessage != null)
        const Gap(10),
        if (widget.validationMessage != null)
          NoteText(
            widget.validationMessage!,
            color: Colors.red,
          )
        else
          const SizedBox(),
        if (widget.additionalNote != null) const Gap(5) else const SizedBox(),
        if (widget.additionalNote != null) NoteText(widget.additionalNote!) else const SizedBox(),
      ],
    );
  }
}
