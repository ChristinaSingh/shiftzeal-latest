import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/common_methods.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'add_position_controller.dart';

class AddPositionScreen extends StatefulWidget {
  const AddPositionScreen({super.key});

  @override
  State<AddPositionScreen> createState() => _AddPositionScreenState();
}

class _AddPositionScreenState extends State<AddPositionScreen> {
  @override
  void initState() {
    super.initState();
    var addPositionController =
        Provider.of<AddPositionController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPositionController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 100.px,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      borderRadius: 15,
                      onPressed: () =>
                          controller.clickOnSaveButton(context: context),
                      text: StringConstants.add),
                ],
              ),
            ),
          ),
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.positions,
              actions: [
                GestureDetector(
                    onTap: () => controller.clickOnAdd(context: context),
                    child: CommonMethods.appIcons(
                        assetName: IconConstants.icAddSquare)),
                SizedBox(
                  width: 24.px,
                )
              ]),
          body: RolesGridApp(),
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

class RolesGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RolesGridScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RolesGridScreen extends StatelessWidget {
  final List<String> roles = [
    "Dsp",
    "Supervisor",
    "Manager",
    "Director",
    "CEO",
    "General Manager",
    "Front Desk",
    "RN",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: roles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cards in a row
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // makes square cards
          ),
          itemBuilder: (context, index) {
            return RoleCard(title: roles[index]);
          },
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;

  RoleCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(height: 12),
          CommonMethods.appIcons(
              assetName: IconConstants.icBackForDashboard,
              height: 24.px,
              width: 24.px),
        ],
      ),
    );
  }
}
