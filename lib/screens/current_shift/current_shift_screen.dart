import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/apis/api_models/get_current_shift_model.dart';

import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/current_shift/current_shift_controller.dart';
import '../../apis/api_models/get_running_shift_model.dart';
import '../../common/common_button.dart';
import '../../common/common_widgets.dart';

class CurrentShiftScreen extends StatefulWidget {
  const CurrentShiftScreen({super.key, required this.runningShift});

  final CurrentShiftData? runningShift;

  @override
  State<CurrentShiftScreen> createState() => _CurrentShiftScreenState();
}

class _CurrentShiftScreenState extends State<CurrentShiftScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CurrentShiftController>(context, listen: false)
          .initMethod(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentShiftController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.currentShift,
          ),
          body: widget.runningShift == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 40.px, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'No current shift available.\nPlease clock in to your current shift, if available.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.px,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
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
                          children: [
                            CommonWidgets.imageView(
                                height: 60.px,
                                width: 60.px,
                                borderRadius: BorderRadius.circular(60.px),
                                image:
                                    widget.runningShift?.userDetails?.image ??
                                        ""),
                            const SizedBox(height: 12),
                            Text(
                              '${widget.runningShift?.userDetails?.firstName ?? ''} ${widget.runningShift?.userDetails?.lastName ?? ''}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildInfoRow(
                                'Date', widget.runningShift?.shiftDate ?? ''),
                            _buildInfoRow('Shift Hour',
                                '${widget.runningShift?.startTime ?? ''} – ${widget.runningShift?.endTime ?? ''}'),
                            _buildInfoRow(
                                'Address', widget.runningShift?.address ?? ''),
                            _buildInfoRow('Position',
                                widget.runningShift?.position ?? ''),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.px,
                      ),
                      CommonPrimaryButton(
                        title: StringConstants.shiftDetails,
                        onTap: () {
                          controller.clickOnShiftSwapButton(
                              context: context,
                              shiftId:
                                  widget.runningShift?.id.toString() ?? "0");
                        },
                      ),
                    ],
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
