import 'package:flutter/material.dart';

import '../app/app_theme.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFEDECF0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

class InsightCard extends StatelessWidget {
  const InsightCard({required this.title, required this.text});
  final String title, text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: lavender.withValues(alpha: .62),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, color: brand),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(text, style: const TextStyle(color: muted, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}
