import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/colors.dart';
import '../../apis/api_models/get_employee_insurance_model.dart';
import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../common/progress_bar.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'employee_details_controller.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({super.key, required this.userId});
  final String userId;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    var myTripController =
        Provider.of<EmployeeDetailsController>(context, listen: false);
    myTripController.initMethod(context: context, userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDetailsController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                StringConstants.employeeDetails,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  NavigationMethods.popMethod(context: context);
                },
                child: CommonMethods.appIcons(
                  assetName: IconConstants.icBack,
                  height: 34.px,
                  width: 34.px,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.px),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25.px)),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      automaticIndicatorColorAdjustment: false,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 12.px,
                              color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 12.px, fontWeight: FontWeight.w700),
                      dividerColor: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                  assetName: IconConstants.icProfileTab),
                              SizedBox(
                                width: 10.px,
                              ),
                              Text(StringConstants.profile)
                            ],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                  assetName: IconConstants.icInsurance),
                              SizedBox(
                                width: 10.px,
                              ),
                              Text(StringConstants.insurance)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ProfileScreen(),
                InsuranceTabScreen(
                  medicalInsuranceList: controller.medicalInsuranceList,
                  otherInsuranceList: controller.otherInsuranceList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    var controller =
        Provider.of<EmployeeDetailsController>(context, listen: false);
  }

  // --- UI/UX Improvement: Single reusable widget for detail row ---
  Widget _buildProfileDetailRow(
      BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 5.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 12.px,
                  fontWeight: FontWeight.w600,
                  color: AppLightColors().secondary2,
                ),
          ),
          SizedBox(height: 2.px),
          Text(
            value.isEmpty ? 'None' : value, // Show 'None' if value is empty
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 16.px,
                  color: Color(0XFF424242),
                ),
          ),
          Divider(height: 16.px, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    );
  }
  // ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDetailsController>(
        builder: (context, controller, child) {
      final userData = controller.userData;
      final fullName =
          "${userData?.firstName ?? ''} ${userData?.lastName ?? ''}".trim();

      return Scaffold(
          body: SafeArea(
        child: ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.px),
              padding: EdgeInsets.symmetric(
                  horizontal: 15.px, vertical: 20.px), // Increased padding
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.px),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 0),
                      blurRadius: 14,
                    )
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Use stretch for list items
                  children: [
                    SizedBox(height: 10.px),
                    // Profile Image
                    Center(
                      child: CommonWidgets.imageView(
                          image: controller.inAsyncCall
                              ? StringConstants.defaultNetworkImage
                              : controller.userData?.image ??
                                  StringConstants.defaultNetworkImage,
                          height: 100.px,
                          width: 100.px,
                          borderRadius: BorderRadius.circular(50.px),
                          fit: BoxFit.cover,
                          defaultNetworkImage:
                              StringConstants.defaultNetworkImage),
                    ),
                    SizedBox(height: 30.px),

                    // --- Updated Profile Details List ---
                    _buildProfileDetailRow(
                      context,
                      StringConstants.name,
                      fullName.isEmpty ? 'None' : fullName,
                    ),
                    _buildProfileDetailRow(
                      context,
                      StringConstants.phone,
                      userData?.mobileNumber ?? 'None',
                    ),
                    _buildProfileDetailRow(
                      context,
                      StringConstants.email,
                      userData?.email ?? 'None',
                    ),
                    _buildProfileDetailRow(
                      context,
                      StringConstants.employeeID,
                      userData?.id?.toString() ?? 'None',
                    ),
                    _buildProfileDetailRow(
                      context,
                      StringConstants.role,
                      userData?.position ?? 'None',
                    ),
                    _buildProfileDetailRow(
                      context,
                      StringConstants.maxHoursWeek,
                      'None', // Placeholder value
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    CommonWidgets.commonCustumeButton(
                      onPressed: () {
                        controller.deleteUser(context: context, userDetailsId: userData?.id.toString() ?? "");
                      },
                      borderRadius: 15.px,
                      buttonColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.px),
                        child: Text(
                          "Remove user from organization",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      showLoading: controller.inAsyncCall,
                      context: context,
                    ),

                    SizedBox(height: 20.px),
                  ]),
            ),
          ),
        ),
      ));
    });
  }
}

class InsuranceTabScreen extends StatefulWidget {
  const InsuranceTabScreen({
    super.key,
    required this.medicalInsuranceList,
    required this.otherInsuranceList,
  });

  final List<InsuranceData> medicalInsuranceList;
  final List<InsuranceData> otherInsuranceList;

  @override
  State<InsuranceTabScreen> createState() => _InsuranceTabScreenState();
}

class _InsuranceTabScreenState extends State<InsuranceTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, TextEditingController> _medicalControllers = {};
  final Map<String, FocusNode> _medicalFocusNodes = {};
  final Map<String, TextEditingController> _otherControllers = {};
  final Map<String, FocusNode> _otherFocusNodes = {};

  final List<String> _fieldKeys = const [
    "member_name",
    "group_id",
    "group_name",
    "effective_date", // <-- Date Picker applied here
    "rx_bin_pcn",
    "plan",
    "dependents",
    "type",
    "user_id",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initControllersAndFocusNodes();
    // Add a listener to rebuild the widget when the tab changes (for button change)
    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  String _getInsuranceValue(InsuranceData? data, String key, String type) {
    if (key == 'type') {
      return type;
    }
    if (data == null) {
      return '';
    }
    switch (key) {
      case "member_name":
        return data.memberName ?? '';
      case "group_id":
        return data.groupId ?? '';
      case "group_name":
        return data.groupName ?? '';
      case "effective_date":
        return data.effectiveDate ?? '';
      case "rx_bin_pcn":
        return data.rxBinPcn ?? '';
      case "plan":
        return data.plan ?? '';
      case "dependents":
        return data.dependents ?? '';
      case "user_id":
        return data.userId.toString();
      default:
        return '';
    }
  }

  void _initControllersAndFocusNodes() {
    // Determine if data exists and get the first item, or null
    final medicalData = widget.medicalInsuranceList.isNotEmpty
        ? widget.medicalInsuranceList.first
        : null;
    final otherData = widget.otherInsuranceList.isNotEmpty
        ? widget.otherInsuranceList.first
        : null;

    // Always initialize controllers and focus nodes for all fields

    // Medical Insurance
    for (var key in _fieldKeys) {
      _medicalControllers[key] = TextEditingController(
          text: _getInsuranceValue(medicalData, key, "Medical"));
      _medicalFocusNodes[key] = FocusNode();
    }

    // Other Insurance
    for (var key in _fieldKeys) {
      _otherControllers[key] = TextEditingController(
          text: _getInsuranceValue(otherData, key, "Other"));
      _otherFocusNodes[key] = FocusNode();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(() {}); // Remove the listener
    _tabController.dispose();
    for (var c in _medicalControllers.values) {
      c.dispose();
    }
    for (var f in _medicalFocusNodes.values) {
      f.dispose();
    }
    for (var c in _otherControllers.values) {
      c.dispose();
    }
    for (var f in _otherFocusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  // --- Date Picker Helper Function (Code is the same) ---
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.secondary,
            // header background color
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor, // header text color
              onPrimary: Colors.white, // selected day text color
              onSurface: Colors.black, // default text color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Button text color
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }
  // ------------------------------------

  Widget _buildEditableFields(Map<String, TextEditingController> controllers,
      Map<String, FocusNode> focusNodes) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 16.px, right: 16.px, top: 16.px, bottom: 100.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controllers.entries.map((entry) {
          final key = entry.key;
          final isReadOnly = key == 'type' || key == 'user_id';
          final isDateField = key == 'effective_date';

          // Generate Title Case label text
          final labelText = key
              .replaceAll('_', ' ')
              .split(' ')
              .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
              .join(' ');

          final controller = entry.value;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *** Label Text Widget ***
                Text(
                  labelText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.8),
                      ),
                ),
                SizedBox(height: 6.px), // Space between label and text field
                // *** Text Field Widget ***
                GestureDetector(
                  // Wrap in GestureDetector for Date Picker functionality
                  onTap: isDateField
                      ? () => _selectDate(context, controller)
                      : null,
                  child: AbsorbPointer(
                    // Prevents keyboard from appearing for date field
                    absorbing: isDateField,
                    child: CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      focusNode: focusNodes[key]!,
                      controller: controller,
                      isCard: false,
                      readOnly: isReadOnly ||
                          isDateField, // Date field is also readOnly
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.px, vertical: 20.px),
                      hintText: isReadOnly
                          ? ''
                          : (isDateField ? 'Select Date' : 'Enter $labelText'),
                      suffixIcon: isDateField
                          ? Icon(Icons.calendar_today,
                              size: 20.px,
                              color: Theme.of(context).primaryColor)
                          : null, // Add calendar icon
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- UPDATED SUBMIT FUNCTION FOR MEDICAL INSURANCE (ASYNC API CALL) ---
  void _submitMedicalInsurance() async {
    // 1. Get Controller instance
    final controller =
        Provider.of<EmployeeDetailsController>(context, listen: false);

    // 2. Gather all data from text controllers into a body map
    final Map<String, dynamic> bodyParams = {};
    _medicalControllers.forEach((key, c) {
      bodyParams[key] = c.text;
    });

    final userId = bodyParams['user_id'];
    if (userId == null || userId.isEmpty) {
      CommonWidgets.showMyToastMessage("User ID is missing. Cannot update.");
      return;
    }

    await controller.updateInsuranceDetails(
      context: context,
      bodyParams: bodyParams,
      type: "Medical",
    );
  }
  // ----------------------------------------------------------------------

  // --- UPDATED SUBMIT FUNCTION FOR OTHER INSURANCE (ASYNC API CALL) ---
  void _submitOtherInsurance() async {
    // 1. Get Controller instance
    final controller =
        Provider.of<EmployeeDetailsController>(context, listen: false);

    // 2. Gather all data from text controllers into a body map
    final Map<String, dynamic> bodyParams = {};
    _otherControllers.forEach((key, c) {
      bodyParams[key] = c.text;
    });

    // 3. Validate user_id (since it comes from the widget/init and is mandatory)
    final userId = bodyParams['user_id'];
    if (userId == null || userId.isEmpty) {
      CommonWidgets.showMyToastMessage("User ID is missing. Cannot update.");
      return;
    }

    // 4. Call the controller's update function
    await controller.updateInsuranceDetails(
      context: context,
      bodyParams: bodyParams,
      type: "Other",
    );
  }
  // --------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Determine which button action to show
    final isMedicalTab = _tabController.index == 0;
    final buttonText = isMedicalTab
        ? "Update Medical Insurance Details"
        : "Update Other Insurance Details";

    // Wrap with Consumer to access the controller's loading state
    return Consumer<EmployeeDetailsController>(
      builder: (context, controller, child) {
        // Disable action if API call is in progress
        final submitAction = controller.inAsyncCall
            ? null
            : (isMedicalTab ? _submitMedicalInsurance : _submitOtherInsurance);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            // UI Improvement: Custom title in primary color
            title: Text(
              "Insurance Details",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 20.px,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor, // Use primary color
                  ),
            ),
            centerTitle: true,
            // TabBar remains the same for consistency
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Medical Insurance"),
                Tab(text: "Other Insurance"),
              ],
            ),
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildEditableFields(_medicalControllers, _medicalFocusNodes),
                _buildEditableFields(_otherControllers, _otherFocusNodes),
              ],
            ),
          ),
          // Floating button remains prominent and functional
          floatingActionButton: FloatingActionButton.extended(
            onPressed: submitAction,
            label: Text(
              buttonText,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            icon: controller.inAsyncCall
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.save, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.px),
            ),
            extendedIconLabelSpacing: 10.px,
            extendedPadding: EdgeInsets.symmetric(horizontal: 30.px),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
