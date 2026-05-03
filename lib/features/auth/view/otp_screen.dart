import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text("Enter OTP",
                style: theme.textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Text("We sent a code to your phone/email",
                style: theme.textTheme.bodyMedium),

            const SizedBox(height: 30),

            /// OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: 60,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: "",
                    ),
                    maxLength: 1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/dashboard");
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text("Verify & Continue"),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {},
              child: const Text("Resend OTP"),
            )
          ],
        ),
      ),
    );
  }
}