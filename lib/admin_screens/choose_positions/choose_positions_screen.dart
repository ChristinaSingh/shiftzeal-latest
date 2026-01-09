import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'choose_positions_controller.dart';

class ChoosePositionsScreen extends StatefulWidget {
  const ChoosePositionsScreen({super.key});

  @override
  State<ChoosePositionsScreen> createState() => ChoosePositionsScreenState();
}

class ChoosePositionsScreenState extends State<ChoosePositionsScreen> {
  @override
  void initState() {
    super.initState();
    var choosePositionsController =
        Provider.of<ChoosePositionsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChoosePositionsController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonElevatedButton(
                    context: context,
                    borderRadius: 15.px,
                    onPressed: () {},
                    text: StringConstants.done),
              ],
            ),
          ),
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.choosePositions,
              actions: [

                SizedBox(
                  width: 24.px,
                )
              ]),
          body: Padding(
            padding: EdgeInsets.all(16.px),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
            
                itemCount: controller.roles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ?   Theme.of(context).colorScheme.secondary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        controller.roles[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
