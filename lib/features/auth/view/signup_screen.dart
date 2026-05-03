import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/routes.dart';
import '../controler/auth_controller.dart';


class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  String selectedCountry = "Bangladesh";
  String selectedCurrency = "BDT";
  String selectedLanguage = "English";

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeLanguage(String lang) {
    if (lang == "Bangla") {
      context.setLocale(const Locale('bn'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }

  void handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authController.notifier);

    try {
      debugPrint("🚀 Signup started");

      final data = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "password": passwordController.text.trim(),
        "country": selectedCountry,
        "currency": selectedCurrency,
        "language": selectedLanguage,
      };

      await auth.signup(data);

      debugPrint("✅ Signup success");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } catch (e, stackTrace) {
      debugPrint("❌ Signup error: $e");
      debugPrint("📌 StackTrace: $stackTrace");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authController);

    return Scaffold(
      appBar: AppBar(
        title: Text("signup".tr()),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Form(
            key: _formKey,
            child: ListView(
              children: [

                const SizedBox(height: 20),

                /// NAME
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "name".tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter your name" : null,
                ),

                const SizedBox(height: 16),

                /// PHONE
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "phone".tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter phone number";
                    }

                    final phoneRegex =
                    RegExp(r'^(?:\+880|880|0)?1[3-9]\d{8}$');

                    if (!phoneRegex.hasMatch(value)) {
                      return "Invalid Bangladeshi number";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "password".tr(),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter password";
                    }
                    if (value.length < 6) {
                      return "Min 6 characters required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// COUNTRY
                DropdownButtonFormField<String>(
                  value: selectedCountry,
                  decoration: const InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                  ),
                  items: ["Bangladesh", "USA"]
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedCountry = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// CURRENCY
                DropdownButtonFormField<String>(
                  value: selectedCurrency,
                  decoration: const InputDecoration(
                    labelText: "Currency",
                    border: OutlineInputBorder(),
                  ),
                  items: ["BDT", "USD"]
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedCurrency = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// LANGUAGE
                DropdownButtonFormField<String>(
                  value: selectedLanguage,
                  decoration: const InputDecoration(
                    labelText: "Language",
                    border: OutlineInputBorder(),
                  ),
                  items: ["English", "Bangla"]
                      .map((l) => DropdownMenuItem(
                    value: l,
                    child: Text(l),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedLanguage = value!);
                    changeLanguage(value!);
                  },
                ),

                const SizedBox(height: 24),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : handleSignup,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("create_account".tr()),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// LOGIN LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already_account".tr()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: Text(
                        "login".tr(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}