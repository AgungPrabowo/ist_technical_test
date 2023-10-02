import 'package:flutter/material.dart';

class DialogUtils {
  Future<void> showLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void snackBar(
    BuildContext context,
    String text, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          content: Text(text),
        ))
        .closed
        .then((value) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
  }
}
