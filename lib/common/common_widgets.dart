import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../apis/api_constants/api_key_constants.dart';
import '../constants/icons_constant.dart';
import '../constants/string_constants.dart';
import 'common_methods.dart';
import 'navigation_methos.dart';

class CommonWidgets {
  static appBar(
      {String? title,
      bool wantBackButton = true,
      Widget? extraWidget,
      bool centerTitle = true,
      List<Widget>? actions,
      required BuildContext context}) {
    return AppBar(
      elevation: 0,
      shadowColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: wantBackButton
          ? Row(
              children: [
                SizedBox(
                  width: 20.px,
                ),
                GestureDetector(
                  onTap: () {
                    NavigationMethods.popMethod(context: context);
                  },
                  child: CommonMethods.appIcons(
                    assetName: IconConstants.icBack,
                    height: 34.px,
                    width: 34.px,
                  ),
                ),
              ],
            )
          : extraWidget ?? null,
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 20.px),
      ),
      actions: actions,
    );
  }

  static Widget appBarView({String? title, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            IconConstants.icBack,
            height: 30.px,
            width: 30.px,
          ),
        ),
        Text(
          title ?? '',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 20.px),
        ),
        const SizedBox(),
      ],
    );
  }

  static Widget shimmerView(
      {double? height, double? width, required BuildContext context}) {
    return SizedBox(
      height: height ?? 64.px,
      width: width ?? double.infinity,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.onSecondary.withOpacity(.4.px),
        highlightColor: Theme.of(context).colorScheme.onSecondary,
        child: Container(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.4.px),
        ),
      ),
    );
  }

  static Widget appIcons(
      {required String assetName,
      double? width,
      double? height,
      double? borderRadius,
      Color? color,
      BoxFit? fit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.px),
      child: Image.asset(
        assetName,
        height: height ?? 24.px,
        width: width ?? 24.px,
        color: color,
        fit: fit ?? BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height ?? 24.px,
            width: width ?? 24.px,
          );
        },
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton(
      {double? height,
      double? width,
      required BuildContext context,
      EdgeInsetsGeometry? buttonMargin,
      EdgeInsetsGeometry? contentPadding,
      double? borderRadius,
      Color? splashColor,
      bool wantContentSizeButton = false,
      Color? buttonColor,
      TextStyle? textStyle,
      double? elevation,
      required VoidCallback onPressed,
      required String text}) {
    return Container(
      height: wantContentSizeButton ? height : 50.px,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 25.px),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.px,
          padding: contentPadding,
          textStyle: textStyle ??
              Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25.px),
          ),
          backgroundColor: buttonColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor:
              splashColor ?? Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  static Widget normalTextFieldForLoginSignUP({
    double? elevation,
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    double? horizontalPadding,
    double? prefixIconHorizontal,
    bool wantBorder = false,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool? filled,
    bool isCard = false,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.all(1.4.px),
      decoration: BoxDecoration(
        color: const Color(0XffF0F0F0),
        borderRadius: BorderRadius.circular(borderRadius ?? 14.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.px),
        child: Row(
          children: [
            prefixIcon ?? const SizedBox(),
            Flexible(
              child: TextFormField(

                focusNode: focusNode,
                obscureText: obscureText,
                onTap: onTap,
                // ✅ Fix: if it's password field, force maxLines = 1
                maxLines: obscureText ? 1 : (maxLines ?? 1),
                maxLength: maxLength,
                textInputAction: textInputAction,
                cursorHeight: cursorHeight,
                cursorColor: Theme.of(context).primaryColor,
                autovalidateMode: autoValidateMode,
                controller: controller,
                onChanged: onChanged ??
                        (value) {
                      value = value.trim();
                      if (value.isEmpty ||
                          value.replaceAll(" ", "").isEmpty) {
                        controller?.text = "";
                      }
                    },
                validator: validator,
                keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                    ? const TextInputType.numberWithOptions(
                    decimal: true, signed: true)
                    : keyboardType ?? TextInputType.text,
                readOnly: readOnly,
                autofocus: autofocus,
                inputFormatters: inputFormatters,
                textCapitalization: textCapitalization,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.px, color: Colors.black),
                decoration: InputDecoration(
                  errorText: errorText,
                  counterText: '',
                  errorStyle: errorStyle ??
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                  hintText: hintText,
                  labelText: labelText,
                  labelStyle: labelStyle,
                  fillColor: fillColor ?? Theme.of(context).primaryColor,
                  filled: filled ?? false,
                  contentPadding: contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintStyle:
                  hintStyle ?? Theme.of(context).textTheme.titleMedium,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            suffixIcon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  static Widget normalDropdownField({
    required BuildContext context,
    required List<Map<String, dynamic>> items, // [{id, name, image}]
    String? value, // selected userId
    String? hintText,
    String? labelText,
    String? errorText,
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String?>? onChanged,
    Widget? prefixIcon,
    Widget? suffixIcon,
    double? horizontalPadding,
    double? borderRadius,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    bool isExpanded = true,
  }) {
    return Container(
      margin: EdgeInsets.all(1.4.px),
      decoration: BoxDecoration(
        color: const Color(0XffF0F0F0),
        borderRadius: BorderRadius.circular(borderRadius ?? 14.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.px),
        child: Row(
          children: [
            prefixIcon ?? const SizedBox(),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: value, // this will hold userId
                isExpanded: isExpanded,
                decoration: InputDecoration(
                  errorText: errorText,
                  counterText: '',
                  errorStyle: errorStyle ??
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                  hintText: hintText,
                  labelText: labelText,
                  labelStyle: labelStyle,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintStyle:
                  hintStyle ?? Theme.of(context).textTheme.titleMedium,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.px),
                items: items.map((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'], // 👈 store id for API
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(user['image'] ?? ""),
                        ),
                        const SizedBox(width: 10),
                        Text(user['name'] ?? ""),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (selectedId) {
                  controller?.text = selectedId ?? "";
                  if (onChanged != null) onChanged(selectedId);
                },
              ),
            ),
            suffixIcon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }



  static Widget commonTextFieldForLoginSignUP(
      {double? elevation,
      String? hintText,
      String? labelText,
      String? errorText,
      String? title,
      TextStyle? titleStyle,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      int? maxLines,
      double? cursorHeight,
      bool wantBorder = false,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      TextInputType? keyboardType,
      double? borderRadius,
      double? maxHeight,
      TextStyle? hintStyle,
      TextStyle? style,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      bool readOnly = false,
      bool hintTextColor = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      AutovalidateMode? autoValidateMode,
      int? maxLength,
      GestureTapCallback? onTap,
      bool obscureText = false,
      FocusNode? focusNode,
      MaxLengthEnforcement? maxLengthEnforcement,
      bool? filled,
      bool isCard = false,
      required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFF0F0F0),
        // gradient: isCard
        //     ? CommonMethods.commonLinearGradientView(context: context)
        //     : CommonMethods.commonLinearGradientViewGrey(context: context),
        borderRadius: BorderRadius.circular(borderRadius ?? 14.px),
      ),
      child: Container(
        margin: EdgeInsets.all(1.px),
        decoration: BoxDecoration(
          color: Color(0XFFF0F0F0),
          borderRadius: BorderRadius.circular(borderRadius ?? 14.px),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 2.px),
          child: Row(
            children: [
              /*prefixIcon != null
                  ? Row(children: [
                prefixIcon,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.px),
                  child: Container(
                    width: 1.4.px,
                    height: 30.px,
                    decoration: BoxDecoration(
                      gradient: isCard
                          ? CommonMethods.commonLinearGradientView(context: context)
                          : CommonMethods.commonLinearGradientViewGrey(context: context),
                    ),
                  ),
                ),
              ])
                  : const SizedBox(),*/
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonMethods.textViewLinearGradient(
                              text: title, value: isCard, context: context),
                        ],
                      ),
                      SizedBox(
                        height: 34.px,
                        child: TextFormField(
                          focusNode: focusNode,
                          maxLengthEnforcement: maxLengthEnforcement,
                          obscureText: obscureText,
                          onTap: onTap,
                          maxLength: maxLength,
                          cursorHeight: cursorHeight,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          autovalidateMode: autoValidateMode,
                          controller: controller,
                          onChanged: onChanged ??
                              (value) {
                                value = value.trim();
                                if (value.isEmpty ||
                                    value.replaceAll(" ", "").isEmpty) {
                                  controller?.text = "";
                                }
                              },
                          validator: validator,
                          keyboardType:
                              keyboardType ?? TextInputType.streetAddress,
                          readOnly: readOnly,
                          autofocus: autofocus,
                          inputFormatters: inputFormatters,
                          textCapitalization: textCapitalization,
                          style: style ??
                              Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 14.px),
                          decoration: InputDecoration(
                            errorText: errorText,
                            counterText: '',
                            errorStyle: errorStyle ??
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                            // suffixIcon: suffixIcon,
                            // prefixIcon: prefixIcon,
                            hintText: hintText,
                            labelText: labelText,
                            labelStyle: labelStyle,
                            fillColor: fillColor ??
                                Theme.of(context).colorScheme.secondary,
                            filled: filled ?? false,
                            contentPadding: contentPadding ??
                                EdgeInsets.only(bottom: 10.px),
                            hintStyle: hintStyle ??
                                Theme.of(context).textTheme.titleMedium,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon != null
                  ? Row(children: [
                      /* Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.px),
                  child: Container(
                    width: 1.4.px,
                    height: 30.px,
                    decoration: BoxDecoration(
                      gradient: isCard
                          ? CommonMethods.commonLinearGradientView(context: context)
                          : CommonMethods.commonLinearGradientViewGrey(context: context),
                    ),
                  ),
                ),*/
                      suffixIcon,
                    ])
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  static Widget commonTextFieldDropDownForLoginSignUP(
      {double? elevation,
      String? hintText,
      String? labelText,
      String? errorText,
      String? title,
      TextStyle? titleStyle,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      int? maxLines,
      double? cursorHeight,
      bool wantBorder = false,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      TextInputType? keyboardType,
      double? borderRadius,
      double? maxHeight,
      TextStyle? hintStyle,
      TextStyle? style,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      bool readOnly = false,
      bool hintTextColor = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      AutovalidateMode? autoValidateMode,
      int? maxLength,
      GestureTapCallback? onTap,
      bool obscureText = false,
      FocusNode? focusNode,
      MaxLengthEnforcement? maxLengthEnforcement,
      bool? filled,
      dynamic selectedValue,
      required BuildContext context,
      DropdownSearchOnFind? items,
      ValueChanged<dynamic>? onChanged,
      bool isCard = false}) {
    return Container(
      margin: EdgeInsets.all(1.4.px),
      decoration: BoxDecoration(
        color: Color(0XFFF0F0F0),
        borderRadius: BorderRadius.circular(borderRadius ?? 14.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 2.px),
        child: Column(
          children: [
            Row(
              children: [
                CommonMethods.textViewLinearGradient(
                    text: title, value: isCard, context: context),
              ],
            ),
            SizedBox(
              height: 34.px,
              child: DropdownSearch<dynamic>(
                compareFn: (item1, item2) => item1.id == item2.id,
                items: items,
                suffixProps: DropdownSuffixProps(
                  clearButtonProps: ClearButtonProps(),
                  dropdownButtonProps: DropdownButtonProps(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  baseStyle: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 14.px),
                  decoration: InputDecoration(
                    errorText: errorText,
                    counterText: '',
                    errorStyle: errorStyle ??
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error),
                    hintText: hintText,
                    labelText: labelText,
                    labelStyle: labelStyle,
                    fillColor:
                        fillColor ?? Theme.of(context).colorScheme.secondary,
                    filled: filled ?? false,
                    contentPadding:
                        contentPadding ?? EdgeInsets.only(bottom: 10.px),
                    hintStyle:
                        hintStyle ?? Theme.of(context).textTheme.titleMedium,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      errorText: errorText,
                      counterText: '',
                      errorStyle: errorStyle ??
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error),
                      // suffixIcon: suffixIcon,
                      // prefixIcon: prefixIcon,
                      hintText: hintText,
                      labelText: labelText,
                      labelStyle: labelStyle,
                      fillColor:
                          fillColor ?? Theme.of(context).colorScheme.secondary,
                      filled: filled ?? false,
                      contentPadding:
                          contentPadding ?? EdgeInsets.only(bottom: 10.px),
                      hintStyle:
                          hintStyle ?? Theme.of(context).textTheme.titleMedium,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context)
                        .scaffoldBackgroundColor, // Set the desired background color
                  ),
                  itemBuilder: (context, item, isDisabled, isSelected) {
                    return ListTile(
                      title: Text(
                        item.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget commonTextFieldForMobile(
      {double? elevation,
      String? hintText,
      String? labelText,
      String? errorText,
      TextStyle? titleStyle,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      int? maxLines,
      double? cursorHeight,
      bool wantBorder = false,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      TextInputType? keyboardType,
      double? borderRadius,
      double? maxHeight,
      TextStyle? hintStyle,
      TextStyle? style,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      bool readOnly = false,
      bool hintTextColor = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      AutovalidateMode? autoValidateMode,
      int? maxLength,
      GestureTapCallback? onTap,
      bool obscureText = false,
      FocusNode? focusNode,
      MaxLengthEnforcement? maxLengthEnforcement,
      bool? filled,
      InputBorder? border,
      InputBorder? disabledBorder,
      InputBorder? errorBorder,
      InputBorder? enabledBorder,
      InputBorder? focusedErrorBorder,
      InputBorder? focusedBorder,
      required BuildContext context}) {
    return TextFormField(
      focusNode: focusNode,
      maxLengthEnforcement: maxLengthEnforcement,
      obscureText: obscureText,
      onTap: onTap,
      //maxLines: maxLines,
      maxLength: maxLength,
      cursorHeight: cursorHeight,
      cursorColor: Theme.of(context).primaryColor,
      autovalidateMode: autoValidateMode,
      controller: controller,
      onChanged: onChanged ??
          (value) {
            value = value.trim();
            if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
              controller?.text = "";
            }
          },
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.streetAddress,
      readOnly: readOnly,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: style ??
          Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontSize: 14.px, color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        counterText: '',
        errorStyle: errorStyle ??
            Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.error),
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle ?? Theme.of(context).textTheme.titleMedium,
        fillColor: fillColor ?? Theme.of(context).primaryColor,
        filled: filled ?? false,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
        hintStyle: hintStyle ?? Theme.of(context).textTheme.titleMedium,
        disabledBorder: disabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(.1.px)),
              borderRadius: BorderRadius.circular(14.px),
            ),
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(.1.px),
                  width: 2.px),
              borderRadius: BorderRadius.circular(14.px),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 2.px),
              borderRadius: BorderRadius.circular(14.px),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(.1.px),
                  width: 2.px),
              borderRadius: BorderRadius.circular(14.px),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 2.px),
              borderRadius: BorderRadius.circular(14.px),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 2.px),
              borderRadius: BorderRadius.circular(14.px),
            ),
      ),
    );
  }

  static Widget textField({
    required String hintText,
    required BuildContext context,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
    double? elevation,
    String? labelText,
    String? errorText,
    String? title,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    bool wantBorder = false,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    MaxLengthEnforcement? maxLengthEnforcement,
    bool? filled,
    bool isCard = false,
  }) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
      focusNode: focusNode,

      keyboardType: keyboardType ?? TextInputType.emailAddress,
      maxLengthEnforcement: maxLengthEnforcement,
      obscureText: obscureText,
      onTap: onTap,
      maxLength: maxLength,
      cursorHeight: cursorHeight,
      cursorColor: Theme.of(context).colorScheme.secondary,
      controller: controller,
      onChanged: onChanged ??
          (value) {
            value = value.trim();
            if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
              controller?.text = "";
            }
          },
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF8F8F8),
        hintText: hintText,
        suffixIcon: suffixIcon,

        //contentPadding: EdgeInsets.symmetric(horizontal: 10.px),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontSize: 14.px),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64.px,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.px),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              color:
                  Theme.of(context).colorScheme.onSecondary.withOpacity(.2.px),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.px),
                child: Icon(Icons.error, color: Theme.of(context).primaryColor),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context)
                    .colorScheme
                    .onSecondary
                    .withOpacity(.4.px),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(.4.px),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static switchButton(
      {bool value = false,
      ValueChanged<bool>? onChanged,
      required BuildContext context}) {
    return CupertinoSwitch(
      activeColor: Theme.of(context).primaryColor,
      value: value,
      onChanged: onChanged,
    );
  }

  static Widget commonOtpView(
          {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
          PinCodeFieldShape? shape,
          TextInputType keyboardType = TextInputType.number,
          List<TextInputFormatter>? inputFormatters,
          TextEditingController? controller,
          ValueChanged<String>? onChanged,
          ValueChanged<String>? onCompleted,
          int? length,
          double? height,
          double? width,
          double? borderRadius,
          double? borderWidth,
          bool readOnly = false,
          bool autoFocus = true,
          bool enableActiveFill = true,
          bool enablePinAutofill = true,
          bool autoDismissKeyboard = true,
          TextStyle? textStyle,
          Color? cursorColor,
          Color? inactiveColor,
          Color? inactiveFillColor,
          Color? activeColor,
          Color? activeFillColor,
          Color? selectedColor,
          Color? selectedFillColor,
          required BuildContext context}) =>
      PinCodeTextField(
        length: length ?? 5,
        mainAxisAlignment: mainAxisAlignment,
        appContext: context,
        cursorColor: cursorColor ?? Theme.of(context).primaryColor,
        autoFocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        readOnly: readOnly,
        textStyle: textStyle ?? Theme.of(context).textTheme.headlineMedium,
        autoDisposeControllers: false,
        enabled: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          inactiveColor: const Color(0xffF7F8F8),
          activeFillColor: const Color(0xffF7F8F8),
          inactiveFillColor: const Color(0xffF7F8F8),
          selectedFillColor: const Color(0xffF7F8F8),
          activeColor: const Color(0xffF7F8F8),
          selectedColor: Theme.of(context).colorScheme.primary,
          shape: shape ?? PinCodeFieldShape.box,
          fieldWidth: width ?? 60.px,
          fieldHeight: height ?? 60.px,
          borderWidth: borderWidth ?? 1.px,
          borderRadius: BorderRadius.circular(borderRadius ?? 15.px),
        ),
        enableActiveFill: enableActiveFill,
        controller: controller,
        onChanged: onChanged,
        enablePinAutofill: enablePinAutofill,
        onCompleted: onCompleted,
        autoDismissKeyboard: autoDismissKeyboard,
      );

  static void showAlertDialog(
      {String title = StringConstants.logout,
      String content = StringConstants.wouldYouLikeToLogout,
      VoidCallback? onPressedYes,
      required BuildContext context}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              NavigationMethods.popMethod(context: context);
            },
            child: const Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }

  static void showAlertDeleteProfile(
      {String title = StringConstants.delete,
      String content = StringConstants.wouldYouLikeToDeleteProfile,
      VoidCallback? onPressedYes,
      required BuildContext context}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              NavigationMethods.popMethod(context: context);
            },
            child: const Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }

  static Widget commonCustumeButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    required BuildContext context,
    Widget? child,
    Decoration? decoration,
    BoxBorder? border,
  }) {
    final _kSize = 40.px; // Adjust based on your design

    return Container(
      height: height ?? 60.px,
      width: width ?? double.infinity,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.px),
            color: buttonColor ?? Theme.of(context).primaryColor,
          ),
      clipBehavior: Clip.hardEdge,
      child: showLoading
          ? Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Theme.of(context).scaffoldBackgroundColor,
                size: _kSize,
              ),
            )
          : GestureDetector(
              onTap: onPressed,
              child: Container(
                height: height ?? 60.px,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                decoration: decoration ??
                    BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(borderRadius ?? 15.px),
                      border: border,
                      color: buttonColor ?? Theme.of(context).primaryColor,
                    ),
                child: child,
              ),
            ),
    );
  }

  static InputDecoration inputDecoration(
      {String? hintText,
      String? labelText,
      String? errorText,
      EdgeInsetsGeometry? contentPadding,
      Color? fillColor,
      TextStyle? hintStyle,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      Widget? suffixIcon,
      Widget? prefixIcon,
      bool? filled,
      required BuildContext context}) {
    return InputDecoration(
      errorText: errorText,
      counterText: '',
      errorStyle: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.error),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: Theme.of(context).textTheme.titleMedium,
      fillColor: Theme.of(context).primaryColor,
      // filled: filled ?? false,
      contentPadding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
      hintStyle: Theme.of(context).textTheme.titleMedium,
      disabledBorder: border(
          color: Theme.of(context).colorScheme.surface, context: context),
      border: border(
          color: Theme.of(context).colorScheme.surface, context: context),
      errorBorder: border(
          color: Theme.of(context).colorScheme.surface, context: context),
      enabledBorder: border(
          color: Theme.of(context).colorScheme.surface, context: context),
      focusedErrorBorder: border(context: context),
      focusedBorder: border(context: context),
    );
  }

  static border({Color? color, required BuildContext context}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: color ?? Theme.of(context).primaryColor, width: 2.px),
      borderRadius: BorderRadius.circular(14.px),
    );
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // return result;
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  ///For Check Post Api Response
  static Future<bool> responseCheckForPostMethod(
      {http.Response? response, bool wantSnackBar = true}) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.message]);
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.error]);
      }
    }
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  ///For Check Get Api Response
  static Future<bool> responseCheckForGetMethod({
    http.Response? response,
    bool wantSuccessToast = false,
    bool wantErrorToast = true,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      snackBarView1({String title = '', required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(title,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 14.px)),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackbarController snackBarView({String title = ''}) {
    return Get.snackbar(margin: EdgeInsets.all(20.px), 'Message', title);
  }

  static void showImagePopup(
      {required String image, required BuildContext context}) {
    Get.bottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        Column(children: [
          SizedBox(height: 40.px),
          CommonWidgets.appBar(context: context),
          CommonWidgets.imageView(
              image: image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2.px,
              borderRadius: BorderRadius.circular(20.px),
              fit: BoxFit.contain)
        ]),
        isScrollControlled: true);
    /*showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CommonWidgets.imageView(
              image: image,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              borderRadius: BorderRadius.circular(20.px),
              fit:  BoxFit.contain
            ),
          ),
        );
      },
    );*/
  }

  static void showMyToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static lightBlueColorContainerText(
      {required String title,
      required BuildContext context,
      Color? color,
      double? fontSize,
      String? icon,
      GestureTapCallback? onTap,
      EdgeInsetsGeometry? padding}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: fontSize ?? 14.px,
                  color: color ?? Theme.of(context).primaryColor),
            ),
            if (icon != null)
              CommonMethods.appIcons(
                  assetName: icon,
                  color: color ?? Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}

enum ErrorAnimationType { shake, clear }
