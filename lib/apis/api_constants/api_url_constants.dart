class ApiUrlConstants {
  static String baseUrl =
      'https://server-php-8-3.technorizen.com/ShiftRoster/api/';
  static String signup = '${baseUrl}auth/signup';
  static String login = '${baseUrl}auth/login';
  static String endPointOfGetProfile = '${baseUrl}auth/get-profile';
  static String endPointOfGetEmployeeProfile = '${baseUrl}get-profile-detail';

  static String endPointOfUpdateInsuranceDetails =
      '${baseUrl}shift/add_insurance';
  static String endPointOfPasswordReset = '${baseUrl}auth/password-reset';
  static String endPointOfCreateNewPassword =
      '${baseUrl}auth/create-new-password';
  static String verifyOtp = '${baseUrl}auth/verify-otp';
  static String endPointOfGetMyShifts = '${baseUrl}shift/get_my_shift';
  static String endPointOfGetMyShiftsAdmin =
      '${baseUrl}company/get_my_shift_by_admin';
  static String endPointOfDeleteShift = '${baseUrl}company/delete_shift';
  static String endPointOfDeleteEmployee =
      '${baseUrl}shift/delete_employee_by_id';

  static String endPointOfGetMyShiftDetails =
      '${baseUrl}shift/get_shift_details';
  static String endPointOfGetMyShiftTask = '${baseUrl}shift/get_shift_details';
  static String endPointOfGetDateWiseShifts =
      '${baseUrl}shift/get_shift_by_date';
  static String endPointOfGetAnnouncements = '${baseUrl}get_announcement';
  static String endPointOfGetOpenShiftDetails =
      '${baseUrl}shift/get_open_shift_by_date';
  static String endPointOfGetOpenShiftAcceptReject =
      '${baseUrl}shift/shift_accept_cancel';
  static String endPointOfGetRunningShift = '${baseUrl}shift/get_running_shift';
  static String endPointOfGetShiftTasks = '${baseUrl}shift/get_task_shiftid';
  static String endPointOfGetCurrentShift = '${baseUrl}shift/get_current_shift';
  static String endPointOfGetShiftTaskDetails =
      '${baseUrl}shift/get_task_details_taskid';
  static String endPointOfCheckIn_Out =
      '${baseUrl}shift/shift_checkin_checkout';
  static String endPointOfGetAllUsers =
      '${baseUrl}chat/get_employee_code_by_users';
  static String endPointOfGetLastMessages = '${baseUrl}chat/get_last_messages';
  static String endPointOfGetChatHistory = '${baseUrl}chat/get_chat';
  static String endPointOfSendMessage = '${baseUrl}chat/insert_chat';
  static String endPointOfSendMailToAuthority =
      '${baseUrl}shift/insert_send_message';
  static String endPointOfUploadUserDocument =
      '${baseUrl}shift/add_user_document';
  static String endPointOfGetUserUploadedDocuments =
      '${baseUrl}shift/get_user_document';
  static String endPointOfGetOrganizationDirectory =
      '${baseUrl}shift/get_directory';
  static String endPointOfGetEmployeeInsurance =
      '${baseUrl}shift/get_insurance';
  static String endPointOfGetEmployeeAbsentShifts =
      '${baseUrl}shift/get_absence_shift';
  static String endPointOfGetEmployeeCompletedShifts =
      '${baseUrl}shift/get_shift_history';

  ///--------------------------------------------------------///
  static String endPointOfAddAnnouncement = '${baseUrl}add_announcement';
  static String endPointOfCreateProfile = '${baseUrl}auth/update-profile';
  static String endPointOfChangePassword = '${baseUrl}auth/change-password';
  static String endPointOfGetPrivacyPolicy =
      '${baseUrl}home/get-privacy-policy';
  static String endPointOfGetTermsAndConditions =
      '${baseUrl}home/get-terms-and-conditions';
  static String endPointOfAskSupport = '${baseUrl}common/ask_support';
  static String endPointOfGetRecommendedHotels =
      '${baseUrl}hotel/get_recommended_hotels';
  static String endPointOfGetPopularHotels =
      '${baseUrl}hotel/get_popular_hotels';
  static String endPointOfSearchHotels = '${baseUrl}hotel/search_hotels';
  static String endPointOfAddRemoveSavedHotel =
      '${baseUrl}hotel/add_remove_saved_hotel';
  static String endPointOfGetSavedHotels = '${baseUrl}hotel/get_saved_hotels';
  static String endPointOfPostHotelById = '${baseUrl}hotel/post_hotel_by_id';
  static String endPointOfListRatting = '${baseUrl}reviews/list_ratting';
  static String endPointOfAddBooking = '${baseUrl}booking/add_booking';
  static String endPointOfAddRatting = '${baseUrl}reviews/add_ratting';
  static String endPointOfGetBookingList = '${baseUrl}booking/get_booking_list';

  /// new api by Ritik Vani ......................///
  static String endPointOfCompanyRegistration =
      '${baseUrl}auth/organization_signup';
  static String endPointOfGetOrganizationEmployees =
      '${baseUrl}company/get_company_by_users';
  static String endPointOfAddEmployeeShift = '${baseUrl}company/add_shift';
  static String endPointOfAddEmployeeShiftTask = '${baseUrl}company/add_task';
  static String endPointOfGetEmployeeShiftTask =
      '${baseUrl}company/get_task_details_by_shift';

  /// ..................supervisor side api..................///

  static String endPointOfSupervisorEmployeesList =
      '${baseUrl}supervisor/shift/get_users_by_supervisor';
  static String endPointOfSupervisorEmployeeShifts =
      '${baseUrl}supervisor/shift/get_shift_by_user';
  static String endPointOfAddSupervisorEmployeeShift =
      '${baseUrl}supervisor/shift/add_shift';
  static String endPointOfAddSupervisorShiftReport =
      '${baseUrl}supervisor/shift/get_shift_report_by_user';
  static String endPointOfUpdateSupervisorShiftReportStatus =
      '${baseUrl}supervisor/shift/approve_shift_report';

}
