import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'create_your_workPlace_controller.dart';

class CreateYourWorkPlaceScreen extends StatefulWidget {
  const CreateYourWorkPlaceScreen({super.key});

  @override
  State<CreateYourWorkPlaceScreen> createState() =>
      _CreateYourWorkPlaceScreenState();
}

class _CreateYourWorkPlaceScreenState extends State<CreateYourWorkPlaceScreen> {
  @override
  void initState() {
    super.initState();
    var createYourWorkPlaceController =
        Provider.of<CreateYourWorkPlaceController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateYourWorkPlaceController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.createANewWorkplace,
          ),
          bottomSheet: Container(
            height: 100.px,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      borderRadius: 15,
                      onPressed: () => controller.clickOnCreateEmployerButton(
                          context: context),
                      text: StringConstants.createEmployer),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                _CustomInputTile(
                  iconPath: IconConstants.icHouse2,
                  text: "XYZ",
                  showClose: true,
                ),
                const SizedBox(height: 20),
                _CustomInputTile(
                  iconPath: IconConstants.icSend2,
                  text: "200 Texas St, Fort Worth, TX 76102, USA",
                ),
                const SizedBox(height: 20),
                _CustomInputTile(
                  iconPath: IconConstants.icProfile2User,
                  text: "1–20",
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.grey.shade300,
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Create Workplace",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }



  decorationForFields({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xffF8F8F8),
      hintText: hintText,
      suffixIcon: suffixIcon,
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
      hintStyle:
          Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14.px),
    );
  }

  Widget textField(
      {required String hintText, Widget? suffixIcon, int? maxLines}) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
      style:
          Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14.px),
      maxLines: maxLines,
      decoration: decorationForFields(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
class _CustomInputTile extends StatelessWidget {
  final String iconPath;
  final String text;
  final bool showClose;

  const _CustomInputTile({
    required this.iconPath,
    required this.text,
    this.showClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 50,
            spreadRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            color: Colors.red,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (showClose)
             CommonMethods.appIcons(assetName: IconConstants.icClose),
        ],
      ),
    );
  }
}

