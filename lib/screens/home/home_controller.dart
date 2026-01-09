import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/time_off_requests/time_off_requests_screen.dart';
import 'package:shiftzeal/apis/api_models/get_current_shift_model.dart';
import 'package:shiftzeal/screens/current_shift/current_shift_screen.dart';
import 'package:shiftzeal/screens/my_shift/my_shift_screen.dart';
import 'package:shiftzeal/screens/open_shift_request/open_shift_request_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_announcements_model.dart';
import '../../apis/api_models/get_running_shift_model.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';

class HomeController extends ChangeNotifier {
  bool clockInValue = true;
  bool inAsyncCall = false;
  CurrentShiftData? currentShiftData;
  List<AnnouncementData> announcementList = [];
  RunningShift? runningShift;
  RunningShift? nextShift;
  double? currentLatitude;
  double? currentLongitude;
  String? currentAddress;
  bool? isWorkingShift = false;
  String username = "User";
  String userImage = "";
  String userPosition = "";
  void clickOnTimeOffRequests({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: TimeOffRequestsScreen(),
    );
  }

  void clickOnShiftRequests({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: OpenShiftRequestScreen(),
    );
  }

  void getUserDetails({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    username = sp.getString(ApiKeyConstants.name) ?? "";
    userImage = sp.getString(ApiKeyConstants.image) ?? "";
    userPosition = sp.getString(ApiKeyConstants.position) ?? "" ;
    notifyListeners();
  }

  void clickOnJoinARegisteredEmployer({required BuildContext context}) {
  }

  void clickOnClockIn({required BuildContext context}) async {
    getLocation(context);
  }

  void getLocation(context) async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude != null && longitude != null) {
      currentLatitude = latitude;
      currentLongitude = longitude;
      print('Latitude: $latitude, Longitude: $longitude');
      debugPrint("hello your location is ");
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        Placemark place = placemarks.first;

        currentAddress = [
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
          if (place.administrativeArea != null &&
              place.administrativeArea!.isNotEmpty)
            place.administrativeArea,
          if (place.country != null && place.country!.isNotEmpty) place.country,
          if (place.postalCode != null && place.postalCode!.isNotEmpty)
            place.postalCode,
        ].join(', ');

        print('Address: $currentAddress');
        checkInApi(context: context);
      } catch (e) {
        print("Failed to get address: $e");
      }
    }
  }

  void getLocationForCheckOut(context) async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude != null && longitude != null) {
      currentLatitude = latitude;
      currentLongitude = longitude;

      print('Latitude: $latitude, Longitude: $longitude');
      debugPrint("hello your location is ");
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        Placemark place = placemarks.first;

        currentAddress = [
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
          if (place.administrativeArea != null &&
              place.administrativeArea!.isNotEmpty)
            place.administrativeArea,
          if (place.country != null && place.country!.isNotEmpty) place.country,
          if (place.postalCode != null && place.postalCode!.isNotEmpty)
            place.postalCode,
        ].join(', ');

        print('Address: $currentAddress');
        checkOutApi(context: context);
      } catch (e) {
        print("Failed to get address: $e");
      }
    }
  }

  void clickOnClockOut({required BuildContext context}) {
    (context);
    getLocationForCheckOut(context);
    notifyListeners();
  }

  void clickOnMyShift({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: MyShiftScreen(),
    );
  }

  void clickOnCurrentShift({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: CurrentShiftScreen(
        runningShift: currentShiftData,
      ),
    );
  }

  void openPdf(String url) async {
    final Uri pdfUrl = Uri.parse(url);
    if (await canLaunchUrl(pdfUrl)) {
      await launchUrl(pdfUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void clickOnOpenShiftRequests({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: OpenShiftRequestScreen(),
    );
  }

  // Fetch Announcements
  Future<void> getUserAnnouncements({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
      };

      GetAnnouncementModel? announcementModel =
          await ApiMethods.getAnnouncementApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (announcementModel != null &&
          announcementModel.status != null &&
          announcementModel.status != "0") {
        announcementList = announcementModel.data ?? [];
      } else {
        final msg = announcementModel?.message ?? "Something went wrong";
        // CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      // CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  Future<void> getRunningShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
      };

      GetRunningShiftModel? getRunningShiftModel =
          await ApiMethods.getRunningShiftApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (getRunningShiftModel != null &&
          getRunningShiftModel.status != null &&
          getRunningShiftModel.status != "0") {
        nextShift = getRunningShiftModel.data?.nextShift;
      } else {
        runningShift = null;
        nextShift = null;
        // final msg = getRunningShiftModel?.message ?? "Something went wrong";
        // CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      runningShift = null;
      nextShift = null;
      // CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentShiftDetails({
    required BuildContext context,
  }) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    try {
      final body = {"user_id": userId};
      final model = await ApiMethods.getCurrentShiftApi(
        context: context,
        bodyParams: body,
      );
      if (model != null && model.status != "0") {
        currentShiftData = model.data;
        isWorkingShift = true;
      } else {
        // CommonWidgets.showMyToastMessage(model?.message ?? "No shift found");
      }
    } catch (e) {
      // CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  Future<void> checkInApi({
    required BuildContext context,
  }) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    if (nextShift == null) {
      // CommonWidgets.showMyToastMessage("No upcoming shift found.");
      inAsyncCall = false;
      notifyListeners();
      return;
    }
    final body = {
      "user_id": userId,
      "shift_id": nextShift!.id.toString(),
      "status": "Checkin",
      "checkin_address": currentAddress.toString(),
      "checkin_lat": currentLatitude.toString(),
      "checkin_lon": currentLongitude.toString(),
    };

    final response = await ApiMethods.checkInApi(
      context: context,
      bodyParams: body,
    );

    inAsyncCall = false;
    notifyListeners();

    if (response == null) {
      // CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    print("response is ${response.status}");

    if (response.status != "0") {
      notifyListeners();
      isWorkingShift = true;
      fetchCurrentShiftDetails(context: context);
      getRunningShifts(context: context);
      CommonWidgets.showMyToastMessage(
          response.message ?? "Checked in successfully");
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }
  }

  Future<void> checkOutApi({
    required BuildContext context,
  }) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    if (currentShiftData == null) {
      CommonWidgets.showMyToastMessage("No shift found.");
      inAsyncCall = false;
      notifyListeners();
      return;
    }
    final body = {
      "user_id": userId,
      "shift_id": currentShiftData!.id.toString(),
      "status": "Checkout",
      "checkin_address": currentAddress.toString(),
      "checkin_lat": currentLatitude.toString(),
      "checkin_lon": currentLongitude.toString(),
    };

    final response = await ApiMethods.checkInApi(
      context: context,
      bodyParams: body,
    );

    inAsyncCall = false;
    notifyListeners();

    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    print("response is ${response.status}");
    if (response.status != "0") {
      isWorkingShift = false;
      notifyListeners();
      fetchCurrentShiftDetails(context: context);
      getRunningShifts(context: context);
      CommonWidgets.showMyToastMessage(
          response.message ?? "Checked in successfully");
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }
  }
}
