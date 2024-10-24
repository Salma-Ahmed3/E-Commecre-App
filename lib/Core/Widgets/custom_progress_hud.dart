import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomProgressHUD extends StatelessWidget {
  const CustomProgressHUD(
      {super.key, required this.inAsyncCall, required this.child});
  final bool inAsyncCall;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: child,
    );
  }
}