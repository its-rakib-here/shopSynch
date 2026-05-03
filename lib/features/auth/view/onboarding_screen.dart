import 'package:flutter/material.dart';


import '../../../core/config/routes.dart';
import '../../../core/storage/token_storage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> slides = [
    {
      "title": "Manage Your Business in One Place",
      "desc":
      "Track your daily sales, understand your customers better, and monitor profit instantly.",
      "image": "assets/images/onboarding.jpg"
    },
    {
      "title": "Works for Shops & Online Sellers",
      "desc":
      "Whether physical or Facebook business, everything stays synced.",
      "image": "assets/images/onboarding.jpg"
    },
    {
      "title": "Simple. Fast. Reliable.",
      "desc":
      "Less time managing software, more time selling.",
      "image": "assets/images/onboarding.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient (similar to your HTML)
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

          /// Main Content
          Column(
            children: [
              /// Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ShopSync Pro",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await TokenStorage.setOnboardingSeen();
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                      child: const Text("Skip"),
                    ),
                  ],
                ),
              ),

              /// Slider
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final item = slides[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Image
                          Container(
                            height: 260,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(item["image"]!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          /// Title
                          Text(
                            item["title"]!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// Description
                          Text(
                            item["desc"]!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// Bottom Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.9),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    /// Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        slides.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 6,
                          width: currentIndex == index ? 24 : 6,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? theme.colorScheme.primary
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.pushNamed(context, AppRoutes.signup);

                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text("Create Account"),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Login Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text("Log In"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}