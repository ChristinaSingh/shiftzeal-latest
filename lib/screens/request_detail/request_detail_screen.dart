import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/screens/request_detail/request_detail_controller.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  @override
  void initState() {
    super.initState();
    var requestDetailController =
        Provider.of<RequestDetailController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestDetailController>(
        builder: (context, controller, child) {
      return Scaffold(
        appBar: CommonWidgets.appBar(context: context,title: "Requests Details"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.px),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.px, vertical: 20.px),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(.2.px),
                    borderRadius: BorderRadius.circular(25.px),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listOfData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.px),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.listOfData[index]['title'] ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: 14.px,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                                Text(
                                  controller.listOfData[index]['value'] ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: 14.px),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.px),
              ],
            ),
          ),
        ),
      );
    });
  }
}
