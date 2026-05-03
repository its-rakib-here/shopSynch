import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/token_storage.dart';
import '../controler/auth_controller.dart';
import '../model/user_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    final phone = phoneController.text.trim();
    final pass = passwordController.text.trim();

    if (phone.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter phone & password")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final auth = ref.read(authController.notifier);

      final result = await auth.login(phone, pass);

      debugPrint("LOGIN RESPONSE: $result");
      debugPrint("RAW RESULT: $result");
      /// 🔥 SAFE DATA EXTRACTION
      final data = result["data"];

      if (data == null) {
        throw Exception("Invalid server response");
      }

      final token = data["accessToken"];

      if (token == null || token.toString().isEmpty) {
        throw Exception("Token missing from response");
      }

      /// 👤 USER MODEL PARSE
      final user = User.fromJson(data["user"]);

      debugPrint("LOGGED USER: ${user.toString()}");

      /// 🔐 SAVE TOKEN
      await TokenStorage.saveToken(token);

      /// (OPTIONAL) SAVE USER
      // await TokenStorage.saveUser(user.toJson());

      if (!mounted) return;

      /// 🚀 NAVIGATE
      Navigator.pushReplacementNamed(
        context,
        "/business_type_screen",
      );

    } catch (e, stack) {
      debugPrint("LOGIN ERROR: $e");
      debugPrintStack(stackTrace: stack);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE0E7FF),
                  Color(0xFFF8FAFC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 25,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Logo
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.store,
                          color: theme.colorScheme.primary, size: 32),
                    ),

                    const SizedBox(height: 14),

                    Text("ShopSync Pro",
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),

                    const SizedBox(height: 6),

                    Text("Login to manage your business",
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.grey)),

                    const SizedBox(height: 24),

                    /// PHONE FIELD
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "017XXXXXXXX",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// PASSWORD FIELD
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                    ),

                    const SizedBox(height: 10),

                    /// FORGOT PASSWORD
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleLogin,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Login"),

                        ),

                      ),

                    ),

                    const SizedBox(height: 16),

                    /// DIVIDER
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// OTP LOGIN
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "/otp");
                      },
                      icon: const Icon(Icons.sms),
                      label: const Text("Login with OTP"),
                    ),

                    const SizedBox(height: 12),

                    /// SIGNUP NAVIGATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/signup");
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
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
        ],
      ),
    );
  }
}