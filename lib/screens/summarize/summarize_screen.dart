import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'summarize_controller.dart';

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => SummarizeScreenState();
}

class SummarizeScreenState extends State<SummarizeScreen> {
  @override
  void initState() {
    super.initState();
    var summarizeController =
        Provider.of<SummarizeController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummarizeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.summarize,
              actions: [
                GestureDetector(
                  onTap: () =>
                      controller.clickOnSummarizeTime(context: context),
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icSummarizeTime,
                      width: 34.px,
                      height: 34.px),
                ),
                SizedBox(
                  width: 20.px,
                )
              ]),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(20.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text("Copy"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 18),
                        label: const Text("Share"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.summaryPoints.length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                if (index !=
                                    controller.summaryPoints.length - 1)
                                  Container(
                                    width: 2,
                                    height: 60,
                                    color: Colors.grey.shade300,
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 24),
                                child: Text(
                                  controller.summaryPoints[index],
                                  style: TextStyle(
                                    fontSize: 16.px,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    "Not Passed Requirement",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
