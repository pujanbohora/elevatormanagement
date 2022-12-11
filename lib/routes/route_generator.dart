import 'package:elevatormaintance/screen/admin/screens/dashboard/add_user_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/admin_all_issue_details_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/all_issues_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/order_list_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/staff_list_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/user_list_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/dashboard/view_user_order_screen.dart';
import 'package:elevatormaintance/screen/admin/screens/main/main_screen.dart';
import 'package:elevatormaintance/screen/auth/register_screen.dart';
import 'package:flutter/material.dart';

import '../constants/route_name.dart';
import '../navigation/navigation_screen.dart';
import '../navigation/splash_screen.dart';
import '../screen/admin/screens/account/admin_account_screen.dart';
import '../screen/auth/login_screen.dart';
import '../screen/customer/account/account_screen.dart';
import '../screen/customer/account/emergency_visit_screen.dart';
import '../screen/customer/account/order_history_screen.dart';
import '../screen/customer/account/qr_code_generate_screen.dart';
import '../screen/customer/account/qr_view.dart';
import '../screen/customer/issues/issue_details_screen.dart';
import '../screen/customer/issues/issue_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen());
      case routeNavigation:
        return MaterialPageRoute(
            builder: (_) => NavigationScreen(data: 0));
      case routeLogin:
        return MaterialPageRoute(
            builder: (_) => LoginScreen());
      case routeOrderHistory:
        return MaterialPageRoute(
            builder: (_) => const OrderHistoryScreen());
      case routeIssue:
        // bool args = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => const UserIssues());
      case routeEmergencyVisit:
        return MaterialPageRoute(
            builder: (_) => const EmergencyVisitScreen());
      case routeIssueDetails:
        dynamic args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => IssueDetailsScreen(args: args,));
      case routeQRGenerator:
        dynamic args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => GenerateQRScreen(args: args,));
      case routeQRScan:
        return MaterialPageRoute(
            builder: (_) => QRViewScreen());
      case routeRegister:
        return MaterialPageRoute(
            builder: (_) => SignupPage());
      case routeAdmin:
        return MaterialPageRoute(
            builder: (_) => MainScreen());
      case routeAdminAccount:
        return MaterialPageRoute(
            builder: (_) => ViewAccountScreen());
      case routeUserList:
        return MaterialPageRoute(
            builder: (_) => UserList());
      case routeAddUser:
        return MaterialPageRoute(
            builder: (_) => CreateUserScreen());
      case routeAllIssues:
        return MaterialPageRoute(
            builder: (_) => ViewAllIssueScreen());
      case routeStaffList:
        return MaterialPageRoute(
            builder: (_) => StaffListScreen());
      case routeOrderList:
        return MaterialPageRoute(
            builder: (_) => OrderListScreen());
      case routeAdminAllIssueDetails:
        dynamic args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AdminAllIssueDetailsScreen(args: args,));
      case routeViewUserOrder:
        dynamic args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ViewUserOrderScreen(args: args,));
      default:
        return MaterialPageRoute(
            builder: (_) => const SafeArea(
              child: Scaffold(
                body: Text("Page not found"),
              ),
            ));
    }
  }
}
