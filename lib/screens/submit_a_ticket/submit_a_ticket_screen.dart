import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'submit_a_ticket_controller.dart';

class SubmitATicketScreen extends StatefulWidget {
  const SubmitATicketScreen({super.key});

  @override
  State<SubmitATicketScreen> createState() => _SubmitATicketScreenState();
}

class _SubmitATicketScreenState extends State<SubmitATicketScreen> {
  @override
  void initState() {
    super.initState();
    var directoryController =
        Provider.of<SubmitATicketController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitATicketController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.submitATicket),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.px),
                  Text(
                    'What are you trying to do?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 14.px, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'Select one...',
                      suffixIcon: SizedBox(
                          height: 24.px,
                          width: 24.px,
                          child: RotatedBox(
                              quarterTurns: 1,
                              child: CommonMethods.appIcons(
                                  assetName:
                                      IconConstants.icArrowRightBlack)))),
                  SizedBox(height: 10.px),
                  Text(
                    'This helps us make sure you get an answer as fast as possible.',
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 10.px),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    'Related Articles',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 14.px, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    'How can we help?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 14.px, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.px),
                  textField(hintText: 'Message (optional)', maxLines: 4),
                  SizedBox(height: 10.px),
                  Text(
                    'Provide as much detail as you can. The more we know, the better we can help',
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 10.px),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    'What are you trying to do?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 14.px, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.px),
                  Image.asset('assets/images/image_add_file.png'),
                  SizedBox(height: 30.px),
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      onPressed: () =>
                          controller.clickOnSubmitButton(context: context),
                      text: StringConstants.submit),
                  SizedBox(height: 10.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textField(
      {required String hintText, Widget? suffixIcon, int? maxLines}) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
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
}
