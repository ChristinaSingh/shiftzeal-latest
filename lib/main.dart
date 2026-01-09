import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/admin_screens/announcements_admin/announcements_admin_controller.dart';
import 'package:shiftzeal/organization_screens/orgranization_registration/organization_registration_controller.dart';
import 'package:shiftzeal/screens/absence/absence_controller.dart';
import 'package:shiftzeal/screens/absence_report/absence_report_controller.dart';
import 'package:shiftzeal/screens/add_document/add_document_controller.dart';
import 'package:shiftzeal/screens/add_preference/add_preference_controller.dart';
import 'package:shiftzeal/screens/add_request/add_request_controller.dart';
import 'package:shiftzeal/screens/availability/availability_controller.dart';
import 'package:shiftzeal/screens/awards_and_rewards/awards_and_rewards_controller.dart';
import 'package:shiftzeal/screens/calendar_sync/calendar_sync_controller.dart';
import 'package:shiftzeal/screens/chat/chat_controller.dart';
import 'package:shiftzeal/screens/chat_detail/chat_detail_controller.dart';
import 'package:shiftzeal/screens/contact_information/contact_information_controller.dart';
import 'package:shiftzeal/screens/create_your_employer/create_your_employer_controller.dart';
import 'package:shiftzeal/screens/create_your_workPlace/create_your_workPlace_controller.dart';
import 'package:shiftzeal/screens/current_shift/current_shift_controller.dart';
import 'package:shiftzeal/screens/daily_report/daily_report_controller.dart';
import 'package:shiftzeal/screens/directory/directory_controller.dart';
import 'package:shiftzeal/screens/document/document_controller.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_controller.dart';
import 'package:shiftzeal/screens/employee_detail/employee_detail_controller.dart';
import 'package:shiftzeal/screens/find_my_invitation/find_my_invitation_controller.dart';
import 'package:shiftzeal/screens/forgot_password/forgot_password_controller.dart';
import 'package:shiftzeal/screens/get_starts/get_starts_controller.dart';
import 'package:shiftzeal/screens/help_screen/help_controller.dart';
import 'package:shiftzeal/screens/history/history_controller.dart';
import 'package:shiftzeal/screens/home/home_controller.dart';
import 'package:shiftzeal/screens/insurance/insurance_controller.dart';
import 'package:shiftzeal/screens/login/login_controller.dart';
import 'package:shiftzeal/screens/more/more_controller.dart';
import 'package:shiftzeal/screens/my_hours/my_hours_controller.dart';
import 'package:shiftzeal/screens/my_shift/my_shift_controller.dart';
import 'package:shiftzeal/screens/nav_bar/nav_bar_controller.dart';
import 'package:shiftzeal/screens/new_password/new_password_controller.dart';
import 'package:shiftzeal/screens/notification_screen/notification_controller.dart';
import 'package:shiftzeal/screens/open_shift_request/open_shift_request_controller.dart';
import 'package:shiftzeal/screens/open_shift_request_details/open_shift_request_details_controller.dart';
import 'package:shiftzeal/screens/open_shift_request_details_basic/open_shift_request_details_basic_controller.dart';
import 'package:shiftzeal/screens/otp/otp_controller.dart';
import 'package:shiftzeal/screens/pay_periods/pay_periods_controller.dart';
import 'package:shiftzeal/screens/pdf_viewer/pdf_viewer_controller.dart';
import 'package:shiftzeal/screens/performance/performance_controller.dart';
import 'package:shiftzeal/screens/profile_setup/profile_setup_controller.dart';
import 'package:shiftzeal/screens/profile_setup/profile_setup_screen.dart';
import 'package:shiftzeal/screens/report/report_controller.dart';
import 'package:shiftzeal/screens/request_detail/request_detail_controller.dart';
import 'package:shiftzeal/screens/requests/requests_controller.dart';
import 'package:shiftzeal/screens/schedule/schedule_controller.dart';
import 'package:shiftzeal/screens/select_employer/select_employer_controller.dart';
import 'package:shiftzeal/screens/select_employer_new/select_employer_new_controller.dart';
import 'package:shiftzeal/screens/select_your_employer/select_your_employer_controller.dart';
import 'package:shiftzeal/screens/sendInvitation/send_Invitation_controller.dart';
import 'package:shiftzeal/screens/send_awards/send_awards_controller.dart';
import 'package:shiftzeal/screens/send_awards_to/send_awards_to_controller.dart';
import 'package:shiftzeal/screens/send_message/send_message_controller.dart';
import 'package:shiftzeal/screens/send_message_user/send_message_user_controller.dart';
import 'package:shiftzeal/screens/setting/setting_controller.dart';
import 'package:shiftzeal/screens/shift_details/shift_details_controller.dart';
import 'package:shiftzeal/screens/shift_swap/shift_swap_controller.dart';
import 'package:shiftzeal/screens/sign_up/sign_up_controller.dart';
import 'package:shiftzeal/screens/splash/splash_controller.dart';
import 'package:shiftzeal/screens/splash/splash_screen.dart';
import 'package:shiftzeal/screens/statictics/statictics_controller.dart';
import 'package:shiftzeal/screens/submit_a_ticket/submit_a_ticket_controller.dart';
import 'package:shiftzeal/screens/successfully/successfully_controller.dart';
import 'package:shiftzeal/screens/summarize/summarize_controller.dart';
import 'package:shiftzeal/screens/supervisor/shift_report_details/shift_report_details_controller.dart';
import 'package:shiftzeal/screens/supervisor/shift_reports/shift_report_controller.dart';
import 'package:shiftzeal/screens/supervisor/supervisor_dashboard/supervisor_dashboard_controller.dart';
import 'package:shiftzeal/screens/supervisor/supervisor_employee_shift_details.dart/supervisor_employee_shif_details_controller.dart';
import 'package:shiftzeal/screens/task/task_controller.dart';
import 'package:shiftzeal/screens/task_detail/task_detail_controller.dart';
import 'package:shiftzeal/screens/time_card_entry/time_card_entry_controller.dart';
import 'package:shiftzeal/screens/time_sheet/time_sheet_controller.dart';
import 'package:shiftzeal/screens/track_time/track_time_controller.dart';
import 'package:shiftzeal/screens/verification_invition/Verification_InvitationScreen_controller.dart';

import 'admin_screens/add_job_sites/add_job_sites_controller.dart';
import 'admin_screens/add_position/add_position_controller.dart';
import 'admin_screens/add_schedules/add_schedules_controller.dart';
import 'admin_screens/add_shift/add_shift_controller.dart';
import 'admin_screens/add_tag/add_tag_controller.dart';
import 'admin_screens/add_task_lists/add_task_lists_controller.dart';
import 'admin_screens/add_user/add_user_controller.dart';
import 'admin_screens/admin_availability/admin_availability_controller.dart';
import 'admin_screens/admin_more/admin_more_controller.dart';
import 'admin_screens/admin_nav_bar/admin_nav_bar_controller.dart';
import 'admin_screens/admin_positions/admin_positions_controller.dart';
import 'admin_screens/admin_schedule/admin_schedule_controller.dart';
import 'admin_screens/admin_send_message/admin_send_message_controller.dart';
import 'admin_screens/admin_users/admin_users_controller.dart';
import 'admin_screens/annotation/annotation_controller.dart';
import 'admin_screens/attendance/attendance_controller.dart';
import 'admin_screens/attendance_notices/attendance_notices_controller.dart';
import 'admin_screens/choose_positions/choose_positions_controller.dart';
import 'admin_screens/dashboard/dashboard_controller.dart';
import 'admin_screens/job_sites/job_sites_controller.dart';
import 'admin_screens/publish_shifts/publish_shifts_controller.dart';
import 'admin_screens/publish_shifts_list/publish_shifts_list_controller.dart';
import 'admin_screens/task_lists/task_lists_controller.dart';
import 'admin_screens/time_off_requests/time_off_requests_controller.dart';
import 'admin_screens/user_activity/user_activity_controller.dart';
import 'admin_setting/admin_setting_controller.dart';
import 'common/theme_data.dart';
import 'organization_screens/Employee_details/employee_details_controller.dart';
import 'organization_screens/add_shift/add_shift_controller.dart';
import 'organization_screens/add_shift_tasks/add_shift_task_controller.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => GetStartsController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => SelectEmployerController()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordController()),
        ChangeNotifierProvider(create: (_) => OtpController()),
        ChangeNotifierProvider(create: (_) => SelectYourEmployerController()),
        ChangeNotifierProvider(create: (_) => NavBarController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => MoreController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => TimeSheetController()),
        ChangeNotifierProvider(create: (_) => PayPeriodsController()),
        ChangeNotifierProvider(create: (_) => SettingController()),
        ChangeNotifierProvider(create: (_) => HistoryController()),
        ChangeNotifierProvider(create: (_) => SendMessageController()),
        ChangeNotifierProvider(create: (_) => AbsenceController()),
        ChangeNotifierProvider(create: (_) => AbsenceReportController()),
        ChangeNotifierProvider(create: (_) => TrackTimeController()),
        ChangeNotifierProvider(create: (_) => DirectoryController()),
        ChangeNotifierProvider(create: (_) => AvailabilityController()),
        ChangeNotifierProvider(create: (_) => AddPreferenceController()),
        ChangeNotifierProvider(create: (_) => RequestsController()),
        ChangeNotifierProvider(create: (_) => CalendarSyncController()),
        ChangeNotifierProvider(create: (_) => InsuranceController()),
        ChangeNotifierProvider(create: (_) => SendAwardsController()),
        ChangeNotifierProvider(create: (_) => DocumentController()),
        ChangeNotifierProvider(create: (_) => AwardsAndRewardsController()),
        ChangeNotifierProvider(create: (_) => SendAwardsToController()),
        ChangeNotifierProvider(create: (_) => SuccessfullyController()),
        ChangeNotifierProvider(create: (_) => PerformanceController()),
        ChangeNotifierProvider(create: (_) => MyShiftController()),
        ChangeNotifierProvider(create: (_) => ShiftDetailsController()),
        ChangeNotifierProvider(create: (_) => ShiftSwapController()),
        ChangeNotifierProvider(create: (_) => TaskController()),
        ChangeNotifierProvider(create: (_) => ScheduleController()),
        ChangeNotifierProvider(create: (_) => TaskDetailController()),
        ChangeNotifierProvider(create: (_) => DailyReportController()),
        ChangeNotifierProvider(create: (_) => AdminNavBarController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => AttendanceNoticesController()),
        ChangeNotifierProvider(create: (_) => UserActivityController()),
        ChangeNotifierProvider(create: (_) => TimeOffRequestsController()),
        ChangeNotifierProvider(create: (_) => AttendanceController()),
        ChangeNotifierProvider(create: (_) => AdminMoreController()),
        ChangeNotifierProvider(create: (_) => AdminUsersController()),
        ChangeNotifierProvider(create: (_) => AdminPositionsController()),
        ChangeNotifierProvider(create: (_) => AddPositionController()),
        ChangeNotifierProvider(create: (_) => AddUserController()),
        ChangeNotifierProvider(create: (_) => AdminSendMessageController()),
        ChangeNotifierProvider(create: (_) => JobSitesController()),
        ChangeNotifierProvider(create: (_) => AddJobSitesController()),
        ChangeNotifierProvider(create: (_) => AddTagController()),
        ChangeNotifierProvider(create: (_) => AnnotationController()),
        ChangeNotifierProvider(create: (_) => AddSchedulesController()),
        ChangeNotifierProvider(create: (_) => AddShiftController()),
        ChangeNotifierProvider(create: (_) => PublishShiftsController()),
        ChangeNotifierProvider(create: (_) => PublishShiftsListController()),
        ChangeNotifierProvider(create: (_) => ChoosePositionsController()),
        ChangeNotifierProvider(create: (_) => StaticticsController()),
        ChangeNotifierProvider(create: (_) => SummarizeController()),
        ChangeNotifierProvider(create: (_) => SubmitATicketController()),
        ChangeNotifierProvider(create: (_) => TimeCardEntryController()),
        ChangeNotifierProvider(create: (_) => ReportController()),
        ChangeNotifierProvider(create: (_) => AddRequestController()),
        ChangeNotifierProvider(create: (_) => ContactInformationController()),
        ChangeNotifierProvider(create: (_) => ChatDetailController()),
        ChangeNotifierProvider(create: (_) => MyHoursController()),
        ChangeNotifierProvider(create: (_) => AddDocumentController()),
        ChangeNotifierProvider(create: (_) => CreateYourEmployerController()),
        ChangeNotifierProvider(create: (_) => EditProfileController()),
        ChangeNotifierProvider(create: (_) => EmployeeDetailController()),
        ChangeNotifierProvider(create: (_) => RequestDetailController()),
        ChangeNotifierProvider(create: (_) => OpenShiftRequestController()),
        ChangeNotifierProvider(create: (_) => PdfViewerProvider()),
        ChangeNotifierProvider(
            create: (_) => OpenShiftRequestDetailsController()),
        ChangeNotifierProvider(create: (_) => FindMyInvitationController()),
        ChangeNotifierProvider(create: (_) => AdminScheduleController()),
        ChangeNotifierProvider(create: (_) => AdminsettingController()),
        ChangeNotifierProvider(create: (_) => AdminAvailabilityController()),
        ChangeNotifierProvider(create: (_) => SendInvitationController()),
        ChangeNotifierProvider(
            create: (_) => VerificationInvitationController()),
        ChangeNotifierProvider(create: (_) => ProfileSetupController()),
        ChangeNotifierProvider(create: (_) => NewPasswordController()),
        ChangeNotifierProvider(create: (_) => SelectEmployerNewController()),
        ChangeNotifierProvider(create: (_) => HelpController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => CreateYourWorkPlaceController()),
        ChangeNotifierProvider(create: (_) => SendMessageUserController()),
        ChangeNotifierProvider(create: (_) => TaskListsController()),
        ChangeNotifierProvider(create: (_) => AddTaskListsController()),
        ChangeNotifierProvider(create: (_) => CurrentShiftController()),
        ChangeNotifierProvider(
            create: (_) => OrganizationRegistrationController()),
        ChangeNotifierProvider(create: (_) => AddEmployeeShiftController()),
        ChangeNotifierProvider(
            create: (_) => AddEmployeeShiftTasksController()),
        ChangeNotifierProvider(create: (_) => AdminAnnouncementController()),
        ChangeNotifierProvider(
            create: (_) => OpenShiftRequestDetailsBasicController()),
        ChangeNotifierProvider(create: (_) => EmployeeDetailsController()),
        ChangeNotifierProvider(create: (_) => SupervisorDashboardController()),
        ChangeNotifierProvider(
            create: (_) => SupervisorEmployeeShiftDetailsController()),
        ChangeNotifierProvider(
            create: (_) => SupervisorShiftReportsController()),
        ChangeNotifierProvider(
            create: (_) => ShiftReportDetailController()),


      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          theme: AppThemeData.themeData(fontFamily: 'Poppins'),
          //darkTheme: AppThemeData.themeData(fontFamily: 'Poppins',lightTheme: false),
        );
      },
    );
  }
}
