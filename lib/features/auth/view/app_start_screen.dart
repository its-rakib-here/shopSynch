import 'package:flutter/material.dart';

import '../../../core/config/routes.dart';
import '../../../core/storage/token_storage.dart';


class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {

  @override
  void initState() {
    super.initState();
    route();
  }

  Future<void> route() async {

    await Future.delayed(const Duration(seconds: 1));

    /// 🔥 STEP 1: onboarding check
    final seenOnboarding = await TokenStorage.isOnboardingSeen();

    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      return;
    }

    /// 🔥 STEP 2: login check
    final token = await TokenStorage.getToken();

    if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    /// 🔥 STEP 3: business check
    final hasBusiness = await TokenStorage.isBusinessSelected();

    if (!hasBusiness) {
      Navigator.pushReplacementNamed(context, AppRoutes.selectBusnessType);
      return;
    }

    /// 🔥 STEP 4: dashboard
    Navigator.pushReplacementNamed(context, AppRoutes.selectBusnessType);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}