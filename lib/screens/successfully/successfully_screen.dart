import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/screens/successfully/successfully_controller.dart';

import '../../constants/string_constants.dart';

class SuccessfullyScreen extends StatefulWidget {
  const SuccessfullyScreen({super.key});

  @override
  State<SuccessfullyScreen> createState() => SuccessfullyScreenState();
}

class SuccessfullyScreenState extends State<SuccessfullyScreen> {
  @override
  void initState() {
    super.initState();
    var successfullyController =
        Provider.of<SuccessfullyController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuccessfullyController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(context: context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24.px),
                child: CommonWidgets.commonElevatedButton(
                  borderRadius: 20.px,
                  context: context,
                  onPressed: () => controller.clickOnBack(context: context),
                  text: StringConstants.back,
                ),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstants.imageSuccessTrophy2,
                    width: 120.px,
                    height: 120.px,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 40.px),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Your award has been successfully sent to ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 16.px),
                        ),
                        TextSpan(
                          text: 'Jaydon Ekstrom!',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 16.px,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
