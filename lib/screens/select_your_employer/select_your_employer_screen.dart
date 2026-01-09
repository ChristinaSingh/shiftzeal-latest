import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'select_your_employer_controller.dart';

class SelectYourEmployerScreen extends StatefulWidget {
  const SelectYourEmployerScreen({super.key});

  @override
  State<SelectYourEmployerScreen> createState() =>
      SelectYourEmployerScreenState();
}

class SelectYourEmployerScreenState extends State<SelectYourEmployerScreen> {
  @override
  void initState() {
    super.initState();
    var selectYourEmployerController =
        Provider.of<SelectYourEmployerController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectYourEmployerController>(
      builder: (context, controller, child) {
        return Scaffold(
            appBar: CommonWidgets.appBar(
                context: context, title: StringConstants.searchYourEmployer),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Search Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: Color(0XFFB8B8B8),
                              ),
                              hintText: 'Search by business name',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.px,
                                  color: Color(0XFFB8B8B8)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Grid Cards
                        Expanded(
                          child: GridView.builder(
                            itemCount: controller.employers.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (context, index) {
                              final employer = controller.employers[index];
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        employer['imageUrl']!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      employer['name']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      employer['address']!,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 10.px,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))));
      },
    );
  }
}
