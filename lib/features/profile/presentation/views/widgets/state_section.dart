import 'package:connectly_app/features/profile/presentation/views/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({
    super.key,
    required this.chatsCount,
    required this.friendsCount,
    required this.createdAt,
  });

  final int chatsCount;
  final int friendsCount;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 1. Chats Card
          Expanded(
            child: InfoCard(
              icon: Icons.chat_bubble_outline,
              label: "Chats",
              value: chatsCount.toString(),
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 12),

          // 2. Friends Card
          Expanded(
            child: InfoCard(
              icon: Icons.people_outline,
              label: "Friends",
              value: friendsCount.toString(),
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 12),

          // 3. Joined Card
          Expanded(
            child: InfoCard(
              icon: Icons.calendar_today_outlined,
              label: "Joined",
              value: DateFormat('MMM yyyy').format(createdAt),
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}