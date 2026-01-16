import 'package:connectly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:connectly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe; // true if the message is sent by current user
  final String? time; // optional time to show
  final bool showStatus; // optional: show check marks

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.time,
    this.showStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : Color(0xFF2C2C2C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 30 : 0),
              topRight: Radius.circular(isMe ? 0 : 30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              if (time != null || showStatus)
                SizedBox(height: 4),
              if (time != null || showStatus)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (time != null)
                      Text(
                        time!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    if (showStatus)
                      SizedBox(width: 5),
                    if (showStatus)
                      Icon(
                        Icons.done_all,
                        size: 14,
                        color: isMe ? Colors.blue : Colors.white54,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
