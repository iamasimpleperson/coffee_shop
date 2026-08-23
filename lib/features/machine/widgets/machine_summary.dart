import 'package:flutter/material.dart';

class MachineSummary extends StatelessWidget {
  final double waterLevel;
  final double beansLevel;
  final bool hasCup;
  final int daysUntilClean;

  const MachineSummary({
    super.key,
    this.waterLevel = 0.5,
    this.beansLevel = 0.5,
    this.hasCup = true,
    this.daysUntilClean = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.water_drop,
                  value: '${(waterLevel * 100).toInt()}%',
                  label: 'water',
                  progress: waterLevel,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SummaryCard(
                  icon: Icons.grain, // Using grain as a substitute for beans
                  value: '${(beansLevel * 100).toInt()}%',
                  label: 'beans',
                  progress: beansLevel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.coffee,
                  value: hasCup ? 'Yes' : 'No',
                  label: 'cup',
                  progress: hasCup ? 1.0 : 0.0,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SummaryCard(
                  icon: Icons.auto_awesome,
                  value: '$daysUntilClean days',
                  label: 'next clean',
                  progress: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final double progress;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: const Color(0xFFEBEBEB),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF63CBA0),
                  ),
                ),
              ),
              Icon(icon, color: Colors.black87, size: 24),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
