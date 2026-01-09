import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import '../../constants/image_constants.dart';
import 'open_shift_request_controller.dart';

class OpenShiftRequestScreen extends StatefulWidget {
  const OpenShiftRequestScreen({super.key});

  @override
  State<OpenShiftRequestScreen> createState() => _OpenShiftRequestScreenState();
}

class _OpenShiftRequestScreenState extends State<OpenShiftRequestScreen> {
  @override
  void initState() {
    super.initState();

    // Call API only after first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OpenShiftRequestController>(context, listen: false)
          .getTodayOpenShifts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OpenShiftRequestController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.openShiftRequests,
          ),

          // Floating Button (Optional)
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: Padding(
          //   padding: EdgeInsets.all(24.px),
          //   child: ...
          // ),

          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: controller.openShifts.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.px),
                      child: Text(
                        "No Open Shifts Available Today",
                        style: TextStyle(
                          fontSize: 14.px,
                          color: Colors.grey ,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.px),
                      child: Column(
                        children: List.generate(
                          controller.openShifts.length,
                          (index) {
                            final shift = controller.openShifts[index];

                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16.px,
                                right: 16.px,
                                bottom: 20.px,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 24),
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
                                    CommonWidgets.imageView(
                                        height: 60.px,
                                        width: 60.px,
                                        borderRadius:
                                            BorderRadius.circular(60.px),
                                        image:
                                            shift.adminDetails?.profileImage ??
                                                ""),
                                    const SizedBox(height: 12),

                                    // Name
                                    Text(
                                      '${shift.adminDetails?.firstName ?? 'N/A'} ${shift.adminDetails?.lastName ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    _buildInfoRow(
                                        'Date', shift.shiftDate ?? 'Unknown'),
                                    _buildInfoRow('Shift Hour',
                                        '${shift.startTime ?? ''} – ${shift.endTime ?? ''}'),
                                    _buildInfoRow(
                                        'Address', shift.address ?? ''),
                                    _buildInfoRow(
                                        'Position', shift.position ?? 'N/A'),

                                    const SizedBox(height: 24),

                                    // Accept / Reject Buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Reject
                                        GestureDetector(
                                          child: const CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.redAccent,
                                            child: Icon(Icons.close,
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            controller.acceptOrRejectOpenShift(
                                              context: context,
                                              shiftId: controller
                                                  .openShifts[index].id
                                                  .toString(),
                                              status: "Cancel",
                                            );
                                          },
                                        ),

                                        // Accept
                                        GestureDetector(
                                          onTap: () {
                                            controller.acceptOrRejectOpenShift(
                                              context: context,
                                              shiftId: controller
                                                  .openShifts[index].id
                                                  .toString(),
                                              status: "Accept",
                                            );
                                          },
                                          child: const CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.green,
                                            child: Icon(Icons.check,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
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
                fontSize: 14.px,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14.px,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
