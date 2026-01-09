import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/navigation_methos.dart';
import 'select_employer_new_controller.dart';

class SelectEmployerNewScreen extends StatefulWidget {
  const SelectEmployerNewScreen({super.key});

  @override
  State<SelectEmployerNewScreen> createState() => _SelectEmployerNewScreenState();
}

class _SelectEmployerNewScreenState extends State<SelectEmployerNewScreen> {
  @override
  void initState() {
    super.initState();
    var selectEmployerNewController =
        Provider.of<SelectEmployerNewController>(context, listen: false);
  }

  String selected = 'business';

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectEmployerNewController>(
      builder: (context, controller, child) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.px),
              Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 28.px),
                      GestureDetector(
                        onTap: () {
                          NavigationMethods.popMethod(context: context);
                        },
                        child: CommonWidgets.appIcons(
                          assetName: IconConstants.icBlueBack,
                          height: 43.px,
                          width: 47.px,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CommonMethods.appIcons(
                      assetName: IconConstants.icSplashLogo,
                      height: 104.px,
                      width: 100.px,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 38.px),
              Text(
                StringConstants.welcomeToShiftZeal,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 24.px),
              ),
              SizedBox(height: 14.px),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.px),
                child: Text(
                  StringConstants.hiThereLetsGet,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.px),
              // Toggle Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleOption(
                    icon: Icons.groups,
                    label: 'Employee',
                    value: 'employee',
                  ),
                  const SizedBox(width: 90),
                  _buildToggleOption(
                    icon: Icons.apartment,
                    label: 'Business',
                    value: 'business',
                  ),
                ],
              ),
              // Display Card
              _buildSelectionCard(controller),
            ],
          ),
        ));
      },
    );
  }

  Widget _buildToggleOption({
    required IconData icon,
    required String label,
    required String value,
  }) {
    bool isSelected = selected == value;
    return GestureDetector(
      onTap: () => setState(() => selected = value),
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white, // or your background color
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, -2), // creates top border effect
                  ),
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-2, 0), // creates left border effect
                  ),
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(2, 0), // creates right border effect
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white, // or your background color
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, -2), // creates top border effect
                  ),
                  BoxShadow(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-2, 0), // creates left border effect
                  ),
                  BoxShadow(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(2, 0), // creates right border effect
                  ),
                ],
              ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: 36,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard(SelectEmployerNewController controller) {
    bool isBusiness = selected == 'business';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary, width: 2),
      ),
      child: Column(
        children: [
          Icon(
            isBusiness ? Icons.apartment : Icons.groups,
            color: Theme.of(context).colorScheme.secondary,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            isBusiness
                ? "I'm setting up my business"
                : "I'm joining as an employee",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isBusiness
                ? "I want to join my team and get my schedule."
                : "I want to access my schedule and tasks.",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              isBusiness
                  ? controller.clickOnIAmSettingUpMyBusiness(context: context)
                  : controller.clickOnIAmAnEmployee(context: context);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
