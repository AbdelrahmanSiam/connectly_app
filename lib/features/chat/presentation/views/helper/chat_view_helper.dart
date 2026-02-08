import 'dart:ui';

import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

Color bubbleColor(dynamic messageModel, bool isMe) {
    if (messageModel.isDeleted) return Colors.grey.shade400;
    return isMe ? AppColors.primary : Colors.grey.shade300;
  }

  BorderRadius bubbleRadius(bool isMe) {
    return BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft:
          isMe ? const Radius.circular(18) : const Radius.circular(4),
      bottomRight:
          isMe ? const Radius.circular(4) : const Radius.circular(18),
    );
  }