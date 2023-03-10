import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required this.content,
    required this.title,
    required this.stopCallBack,
    this.actions,
  });

  final Widget title;
  final Widget content;
  final Function() stopCallBack;
  final List<Widget>? actions;
  final TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            child: Center(
              child: Text(
                'OK',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
            onPressed: () {
              stopCallBack();
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
      ),
    );
  }
}
