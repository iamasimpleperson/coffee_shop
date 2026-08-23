import 'package:coffee_shop/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MachineBloc extends StatefulWidget {
  const MachineBloc({super.key});

  @override
  State<MachineBloc> createState() => _MachineBlocState();
}

class _MachineBlocState extends State<MachineBloc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                'Freya',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFAEF3D3), // Light green
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Ready',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.chevron_right, size: 28),
                onPressed: () => context.go(AppRoutes.machine),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 16),
          // Main Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                // Left Side: Machine Image
                // Expanded(
                //   flex: 1,
                //   child: Center(
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(12),
                //       child: Image(image: )
                //     ),
                //   ),
                // ),
                Expanded(child: SizedBox(width: 300)),
                const SizedBox(width: 16),
                // Right Side: Grid of Indicators
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildIndicator(
                            Icons.water_drop,
                            1.0,
                            const Color(0xFF6AC79E),
                          ),
                          _buildIndicator(
                            Icons.coffee,
                            0.6,
                            const Color(0xFF6AC79E),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildIndicator(
                            Icons.auto_awesome,
                            1.0,
                            const Color(0xFF6AC79E),
                          ),
                          _buildIndicator(
                            Icons.local_cafe,
                            1.0,
                            const Color(0xFF6AC79E),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(IconData icon, double progress, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 52,
          height: 52,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
        ),
        Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87, size: 22),
      ],
    );
  }
}
