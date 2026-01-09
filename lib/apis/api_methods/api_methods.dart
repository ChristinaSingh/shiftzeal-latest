import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shiftzeal/apis/api_models/get_absent_user_shifts_model.dart';
import 'package:shiftzeal/apis/api_models/get_completed_shifts_history_model.dart';
import 'package:shiftzeal/apis/api_models/get_directory_list_model.dart';
import 'package:shiftzeal/apis/api_models/get_my_shift_byDate_model.dart';
import 'package:shiftzeal/apis/api_models/get_my_shift_task_model.dart';
import 'package:shiftzeal/apis/api_models/get_my_shifts_model.dart';
import 'package:shiftzeal/apis/api_models/get_password_reset_model.dart';
import 'package:shiftzeal/apis/api_models/get_profile_model.dart';
import 'package:shiftzeal/apis/api_models/get_shift_details_model.dart';
import 'package:shiftzeal/apis/api_models/get_sign_in_model.dart';
import 'package:shiftzeal/apis/api_models/get_signup_model.dart';
import 'package:shiftzeal/apis/api_models/get_update_password_model.dart';
import 'package:shiftzeal/apis/api_models/get_user_uploader_model.dart';
import 'package:shiftzeal/apis/api_models/send_authority_model.dart';
import 'package:shiftzeal/apis/api_models/update_profile_model.dart';

import '../../../common/http_methods.dart';
import '../api_constants/api_url_constants.dart';
import '../api_models/add_annoucement_model.dart';
import '../api_models/add_shift_by_supervisor_model.dart';
import '../api_models/add_shift_for_employee_model.dart';
import '../api_models/add_shifts_task_model.dart';
import '../api_models/chat_history_model.dart';
import '../api_models/check_in_model.dart';
import '../api_models/delete_employee_model.dart';
import '../api_models/get_all_shifts_model.dart';
import '../api_models/get_all_users_list_model.dart';
import '../api_models/get_announcements_model.dart';
import '../api_models/get_current_shift_model.dart';
import '../api_models/get_employee_insurance_model.dart';
import '../api_models/get_employee_shifts_model.dart';
import '../api_models/get_last_message_list_model.dart';
import '../api_models/get_my_shift_tasks_model.dart';
import '../api_models/get_openShift_accept_reject_model.dart';
import '../api_models/get_open_shift_details_model.dart';
import '../api_models/get_privacy_policy_model.dart';
import '../api_models/get_running_shift_model.dart';
import '../api_models/get_shift_task_details_model.dart';
import '../api_models/get_terms_and_conditions_model.dart';
import '../api_models/get_verify_model.dart';
import '../api_models/organization_registration_model.dart';
import '../api_models/send_message_response_model.dart';
import '../api_models/supervisior/shift_report_data_model.dart';
import '../api_models/supervisor_employee_model.dart';
import '../api_models/update_insuranace_model.dart';
import '../api_models/upload_user_documents_model.dart';
import '../api_models/user_model.dart';

class ApiMethods {
  static Future<SignUpModel?> signupUser(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.signup, context: context, bodyParams: bodyParams);
    if (response != null) {
      return SignUpModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SignInModel?> loginUser(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.login, context: context, bodyParams: bodyParams);
    if (response != null) {
      return SignInModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetProfileModel?> getProfile(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetProfile,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetProfileModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PasswordResetModel?> passwordReset(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfPasswordReset,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return PasswordResetModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<VerifyOtpModel?> verifyOtp(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.verifyOtp,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return VerifyOtpModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UpdatedPasswordModel?> createNewPassword(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfCreateNewPassword,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return UpdatedPasswordModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UpdatedProfileModel?> createProfile({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
    File? image,
    String? imageKey,
  }) async {
    http.Response? response = await MyHttp.multipart(
        url: ApiUrlConstants.endPointOfCreateProfile,
        imageKey: imageKey,
        image: image,
        bodyParams: bodyParams);
    if (response != null) {
      return UpdatedProfileModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> changePassword(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfChangePassword,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetPrivacyPolicyModel?> getPrivacyPolicy(
      {required BuildContext context}) async {
    http.Response? response =
        await MyHttp.getMethod(url: ApiUrlConstants.endPointOfGetPrivacyPolicy);
    if (response != null) {
      return GetPrivacyPolicyModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetTermsAndConditionsModel?> getTermsAndConditions() async {
    http.Response? response = await MyHttp.getMethod(
        url: ApiUrlConstants.endPointOfGetTermsAndConditions);
    if (response != null) {
      return GetTermsAndConditionsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetMyShiftModel?> getMyShiftsApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetMyShifts,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetMyShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// shift details api
  static Future<GetMyShiftDetailsModel?> getMyShiftsDetailsApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetMyShiftDetails,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetMyShiftDetailsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// shift task api
  static Future<GetMyShiftTaskModel?> getMyShiftsTaskApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetMyShiftTask,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetMyShiftTaskModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// date wise shift api

  static Future<GetMyShiftsByDataModel?> getDateWiseShiftsApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetDateWiseShifts,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetMyShiftsByDataModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Announcements API
  static Future<GetAnnouncementModel?> getAnnouncementApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetAnnouncements,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetAnnouncementModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Open Shift Details API
  static Future<GetOpenShiftDetailsModel?> getOpenShiftDetailsApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetOpenShiftDetails,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetOpenShiftDetailsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Open Shift Accept/Reject API
  static Future<GetOpenShiftAcceptRejectModel?> getOpenShiftAcceptRejectApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetOpenShiftAcceptReject,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetOpenShiftAcceptRejectModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Running Shift API
  static Future<GetRunningShiftModel?> getRunningShiftApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetRunningShift,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetRunningShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get shift tasks API
  static Future<GetShiftTasksModel?> getShiftTasksApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetShiftTasks,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null) {
      return GetShiftTasksModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get shift  details tasks API
  static Future<GetShiftTasksDetailsModel?> getShiftTaskDetailsApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetShiftTaskDetails,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetShiftTasksDetailsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get current shift API
  static Future<GetCurrentShiftModel?> getCurrentShiftApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetCurrentShift,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return GetCurrentShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Check-in-out API
  static Future<CheckInModel?> checkInApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfCheckIn_Out,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null) {
      return CheckInModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get All Users API
  static Future<GetAllUsersList?> getAllUsersApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetAllUsers,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null) {
      return GetAllUsersList.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Last Messages API
  static Future<GetLastMessagesListModel?> getLastMessagesApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetLastMessages,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null) {
      return GetLastMessagesListModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Get Chat History API
  static Future<GetChatHistoryModel?> getChatHistoryApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetChatHistory,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return GetChatHistoryModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  /// Send Message API
  static Future<SendMessageResponse?> sendMessageApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfSendMessage,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return SendMessageResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  /// Send Mail to authority API
  static Future<SendMessageToAuthorityModel?> sendMailToAuthorityApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfSendMailToAuthority,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return SendMessageToAuthorityModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Upload User Document API
  static Future<UploadUserDocumentModel?> uploadUserDocument({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
    File? documentFile,
    String? documentKey,
  }) async {
    http.Response? response = await MyHttp.multipart(
      url: ApiUrlConstants.endPointOfUploadUserDocument,
      imageKey: documentKey,
      image: documentFile,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return UploadUserDocumentModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get user uploaded documents API
  static Future<GetUploadedDocumentModel?> getUserUploadedDocuments({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetUserUploadedDocuments,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return GetUploadedDocumentModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get organization directory API
  static Future<GetAllUserDirectoryModel?> getEmployeeDirectory({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetOrganizationDirectory,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return GetAllUserDirectoryModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get employee insurance API
  static Future<GetEmployeeInsuranceModel?> getEmployeeInsurance({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetEmployeeInsurance,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return GetEmployeeInsuranceModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get employee absent shifts details API
  static Future<GetAbsentShiftModel?> getAbsentShiftsData({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetEmployeeAbsentShifts,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return GetAbsentShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get employee completed shift details API
  static Future<GetCompletedShiftModel?> getCompletedShiftsData({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetEmployeeCompletedShifts,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null && response.body.isNotEmpty) {
      return GetCompletedShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// company registration part
  static Future<OrganizationRegistrationModel?> createOrganizationApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
    File? image,
    String? imageKey,
  }) async {
    http.Response? response = await MyHttp.multipart(
        url: ApiUrlConstants.endPointOfCompanyRegistration,
        imageKey: imageKey,
        image: image,
        bodyParams: bodyParams);
    if (response != null) {
      return OrganizationRegistrationModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get organization all employees api
  static Future<GetAllUserDirectoryModel?> getOrganizationEmployees({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetOrganizationEmployees,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return GetAllUserDirectoryModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// add new shift for employee api
  static Future<AddNewShiftForEmployeeModel?> addNewShiftForEmployeesApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfAddEmployeeShift,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return AddNewShiftForEmployeeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// add new shift tasks for employee api
  static Future<AddShiftTasksModel?> addShiftTasksApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfAddEmployeeShiftTask,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return AddShiftTasksModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get  shift tasks for employee api
  static Future<GetShiftTasksModel?> getShiftTasksDataApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfGetEmployeeShiftTask,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return GetShiftTasksModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// add announcement api
  static Future<AddAnnouncementModel?> addAnnouncementApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
    File? image,
    String? imageKey,
  }) async {
    http.Response? response = await MyHttp.multipart(
        url: ApiUrlConstants.endPointOfAddAnnouncement,
        imageKey: imageKey,
        image: image,
        bodyParams: bodyParams);
    if (response != null) {
      return AddAnnouncementModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// get all shifts api for admin
  static Future<AllShiftsModel?> getMyShiftsApiAdmin(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetMyShiftsAdmin,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return AllShiftsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// delete shift api

  static Future deleteShiftApi({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
  }) async {
    final response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfDeleteShift,
      context: context,
      bodyParams: bodyParams,
    );
    if (response != null && response.body.isNotEmpty) {
      return AddNewShiftForEmployeeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetProfileModel?> getEmployeeProfileProfile(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGetEmployeeProfile,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetProfileModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// update insurance details

  static Future<UpdateInsuranceDetailsModel?> updateEmployeeInsurance(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfUpdateInsuranceDetails,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return UpdateInsuranceDetailsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<DeleteEmployeeModel?> deleteUserApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfDeleteEmployee,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return DeleteEmployeeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// ..........................................supervisor section......................

  /// supervisor employee section
  static Future<SupervisorEmployeeModel?> getSupervisorEmployeeList(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfSupervisorEmployeesList,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return SupervisorEmployeeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// supervisor employee shifts data
  static Future<SupervisorEmployeeShiftsModel?> getSupervisorEmployeeShiftApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfSupervisorEmployeeShifts,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return SupervisorEmployeeShiftsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// supervisor employee shifts add new
  static Future<AddShiftModel?> addSupervisorEmployeeShiftApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfAddSupervisorEmployeeShift,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return AddShiftModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// supervisior shift report data

  static Future<GetShiftReportModel?> supervisorShiftReportDataApi(
      {required BuildContext context, Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfAddSupervisorShiftReport,
        context: context,
        bodyParams: bodyParams);
    if (response != null) {
      return GetShiftReportModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// update supervisor shift report status (Approve / Revision)

  static Future<Map<String, dynamic>?> updateShiftReportStatusApi({
    required BuildContext context,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiUrlConstants.endPointOfUpdateSupervisorShiftReportStatus,
      context: context,
      bodyParams: bodyParams,
    );

    if (response != null) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
