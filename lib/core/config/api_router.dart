import 'package:flutter/material.dart';

// AUTH
import '../../features/auth/view/app_start_screen.dart';
import '../../features/auth/view/business_type_screen.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/otp_screen.dart';
import '../../features/auth/view/onboarding_screen.dart';

// DASHBOARD
// import '../../features/dashboard/view/owner_dashboard.dart';
// import '../../features/dashboard/view/worker_dashboard.dart';
//
// // SHOP
// import '../../features/shop/view/shop_list_screen.dart';
// import '../../features/shop/view/shop_create_screen.dart';
//
// // CUSTOMER
// import '../../features/customer/view/customer_list_screen.dart';
// import '../../features/customer/view/customer_detail_screen.dart';
//
// // ORDER
// import '../../features/order/view/order_list_screen.dart';
// import '../../features/order/view/add_order_screen.dart';
// import '../../features/order/view/order_detail_screen.dart';
//
// // INVENTORY
// import '../../features/inventory/view/inventory_list_screen.dart';
// import '../../features/inventory/view/add_product_screen.dart';
//
// // LEDGER
// import '../../features/ledger/view/customer_ledger_screen.dart';
//
// // TEAM
// import '../../features/team/view/team_screen.dart';
// import '../../features/team/view/invite_worker_screen.dart';
//
// // PROFILE
// import '../../features/profile/view/profile_screen.dart';

import '../../features/auth/view/signup_screen.dart';
import '../../features/dashboard/view/online_seller_owner_dashboard.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

    // AUTH
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.selectBusnessType:
        return MaterialPageRoute(builder: (_)=>const BusinessTypeScreen());

      case AppRoutes.onlineSellerOwnerDashboard:
        return MaterialPageRoute(builder: (_)=>const OwnerDashboardScreen());

      case AppRoutes:
        return MaterialPageRoute(builder: (_)=> const AppStartScreen());


    // case AppRoutes.ownerDashboard:
    //   return MaterialPageRoute(builder: (_) => const OwnerDashboard());
    //
    //   case AppRoutes.workerDashboard:
    //     return MaterialPageRoute(builder: (_) => const WorkerDashboard());
    //
    // // SHOP
    //   case AppRoutes.shopList:
    //     return MaterialPageRoute(builder: (_) => const ShopListScreen());
    //
    //   case AppRoutes.shopCreate:
    //     return MaterialPageRoute(builder: (_) => const ShopCreateScreen());
    //
    // // CUSTOMER
    //   case AppRoutes.customerList:
    //     return MaterialPageRoute(builder: (_) => const CustomerListScreen());
    //
    //   case AppRoutes.customerDetail:
    //     return MaterialPageRoute(builder: (_) => const CustomerDetailScreen());
    //
    // // ORDER
    //   case AppRoutes.orderList:
    //     return MaterialPageRoute(builder: (_) => const OrderListScreen());
    //
    //   case AppRoutes.addOrder:
    //     return MaterialPageRoute(builder: (_) => const AddOrderScreen());
    //
    //   case AppRoutes.orderDetail:
    //     return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
    //
    // // INVENTORY
    //   case AppRoutes.inventoryList:
    //     return MaterialPageRoute(builder: (_) => const InventoryListScreen());
    //
    //   case AppRoutes.addProduct:
    //     return MaterialPageRoute(builder: (_) => const AddProductScreen());
    //
    // // LEDGER
    //   case AppRoutes.ledger:
    //     return MaterialPageRoute(builder: (_) => const CustomerLedgerScreen());
    //
    // // TEAM
    //   case AppRoutes.team:
    //     return MaterialPageRoute(builder: (_) => const TeamScreen());
    //
    //   case AppRoutes.inviteWorker:
    //     return MaterialPageRoute(builder: (_) => const InviteWorkerScreen());
    //
    // // PROFILE
    //   case AppRoutes.profile:
    //     return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}