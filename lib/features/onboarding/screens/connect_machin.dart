import 'package:flutter/material.dart';

class ConnectMachin extends StatefulWidget {
  const ConnectMachin({super.key});

  @override
  State<ConnectMachin> createState() => _ConnectMachinState();
}

class _ConnectMachinState extends State<ConnectMachin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7), // Light grayish background
      body: Stack(
        children: [
          // The background is just plain color according to the image,
          // no need for additional elements at the top for now.

          // Bottom Sheet Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Machine Image Container
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFF2F5FF,
                        ), // Light blue tint background for image
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Center(
                        // Using a coffee maker icon as a placeholder for the 3D asset
                        child: Icon(
                          Icons.coffee_maker,
                          size: 72,
                          color: Colors.deepOrange.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    const Text(
                      'Turn on your coffee maker',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Subtitle
                    const Text(
                      "Continue when it's on.",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement Bluetooth connection or next step
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF111111,
                          ), // Almost black
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
