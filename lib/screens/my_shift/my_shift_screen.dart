import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import '../send_message_user/send_message_user_screen.dart';
import 'my_shift_controller.dart';

class MyShiftScreen extends StatefulWidget {
  const MyShiftScreen({super.key});

  @override
  State<MyShiftScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends State<MyShiftScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var myShiftController =
          Provider.of<MyShiftController>(context, listen: false);
      myShiftController.initMethod(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyShiftController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.myShifts,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
          Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.clickOnShiftSwapButton(context: context);
                  },
                  child: Container(
                    height: 60.px,
                    width: MediaQuery.sizeOf(context).width - 40,
                    padding: EdgeInsets.all(5.px),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15.px),
                        border: Border.all(
                            width: 2.px,
                            color: Theme.of(context).primaryColor)),
                    child: Center(
                        child: Text("shift swap",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 17.px,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor))),
                  ),
                ),
              ],
            ),
          ),
          body: controller.shiftList.isEmpty
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show loader or empty message
              :
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: controller.shiftList.length,
            itemBuilder: (context, index) {
              final shift = controller.shiftList[index];
              final user = shift.userDetails;

              return GestureDetector(
                onTap: () {
                  controller.clickOnRightIcon(index: index, context: context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: (user?.image != null && user!.image != "")
                            ? NetworkImage(user.image!)
                            : const NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow('Date', shift.shiftDate ?? ''),
                      _buildInfoRow('Shift Hour', '${shift.startTime ?? ''} – ${shift.endTime ?? ''}'),
                      _buildInfoRow('Address', shift.address ?? ''),
                      _buildInfoRow('Position', user?.position ?? ''),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.clickOnCloseIcon(index: index, context: context);
                            },
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.redAccent,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.clickOnRightIcon(index: index, context: context);
                            },
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.green,
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )

        );
      },
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.px),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.px),
            ),
          ),
        ],
      ),
    );
  }
}
