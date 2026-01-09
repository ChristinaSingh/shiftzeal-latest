import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/image_constants.dart';
import 'common_widgets.dart';

class CommonMethods {
  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static splashLogo({double? width, double? height}) {
    return Image.asset(
      ImageConstants.imageLogo,
      height: height ?? 80.px,
      width: width ?? 140.px,
    );
  }

  static Widget appIcons(
      {required String assetName,
      double? width,
      double? height,
      Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetName,
          height: height ?? 24.px,
          width: width ?? 24.px,
          color: color,
        ),
      ],
    );
  }

  static Widget appIconsPng(
      {required String assetName, double? width, double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetName,
          height: height ?? 24.px,
          width: width ?? 24.px,
        ),
      ],
    );
  }

  static LinearGradient commonLinearGradientView(
          {required BuildContext context}) =>
      LinearGradient(
        end: Alignment.centerLeft,
        begin: Alignment.centerRight,
        colors: [
          Color(0XFF1E88E5),
          Color(0XFF26C6DA),
        ],
      );

  static LinearGradient commonLinearGradientViewPrimary(
          {required BuildContext context}) =>
      LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.secondary,
        ],
      );

  static LinearGradient commonLinearGradientViewGrey(
          {required BuildContext context}) =>
      LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [
          Color(0xff000000),
          Color(0xff000000),
        ],
      );

  static LinearGradient commonLinearGradientViewBlack(
          {required BuildContext context}) =>
      const LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [
          Color(0xff393939),
          Color(0xff393939),
        ],
      );

  static LinearGradient commonLinearGradientViewWhite(
          {required BuildContext context}) =>
      LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
        ],
      );

  static Widget textViewLinearGradient(
          {String? text,
          bool? value,
          TextStyle? style,
          bool primaryColor = false,
          required BuildContext context}) =>
      Center(
        child: GradientWidget(
          text: text,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
          gradient: value ?? true
              ? primaryColor
                  ? commonLinearGradientViewPrimary(context: context)
                  : commonLinearGradientView(context: context)
              : primaryColor
                  ? commonLinearGradientViewBlack(context: context)
                  : commonLinearGradientViewGrey(context: context),
        ),
      );

  static Widget iconLinearGradient(
          {required String assetName,
          double? width,
          double? height,
          bool? value,
          bool primaryColor = false,
          required BuildContext context}) =>
      Center(
        child: GradientWidget(
          gradient:
              commonLinearGradientViewGrey(context: context),
          child: appIcons(assetName: assetName, width: width, height: height , color: Colors.black),
        ),
      );

  static Future<void> commonAndroidNoInternetDialog(
      {bool isDismiss = true,
      GestureTapCallback? onTap,
      required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset(ImageConstants.imageDataNotFound),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Whoops!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "No internet connection found.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Check your connection and try again.",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                /* const SizedBox(height: 8),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(14.px),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.px)),
                    child: Text(
                      "Click Me.",
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
      useSafeArea: true,
      barrierDismissible: isDismiss,
    );
  }

  static void noInternet() {
    CommonWidgets.showMyToastMessage('Please check your internet connection');
  }

  static Widget dataNotFound() {
    return Center(
      child: Image.asset(ImageConstants.imageDataNotFound),
    );
  }
}

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    super.key,
    this.text,
    required this.gradient,
    this.style,
    this.child,
  });

  final String? text;
  final TextStyle? style;
  final Widget? child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child ?? Text(text ?? '', style: style),
    );
  }
}
