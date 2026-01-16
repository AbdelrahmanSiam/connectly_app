import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:flutter/material.dart';

class ChatViewTextField extends StatelessWidget {
  const ChatViewTextField({
    super.key,
    this.keyboardType = TextInputType.text,
  });
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 0,
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF2C2C2C),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
          ),
          hintText: "Message",
          hintStyle: AppTextStyles.textStyle18,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }
}
