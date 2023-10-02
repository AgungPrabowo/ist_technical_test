import 'package:flutter/material.dart';

import '../../profile/view/profile_view.dart';
import '../../utils/cache.dart';
import '../../utils/constant.dart';
import '../model/request_login_model.dart';
import '../services/login_services.dart';

class LoginViewModel extends ChangeNotifier {
  final BuildContext _context;
  final ctrlUsername = TextEditingController(text: "kminchelle");
  final ctrlPassword = TextEditingController(text: "0lelplR");
  final formKey = GlobalKey<FormState>();
  final services = LoginServices();
  var showPassword = false;

  LoginViewModel(this._context) {
    _initial();
  }

  void toggleVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      final payload = RequestLoginModel(
        username: ctrlUsername.text,
        password: ctrlPassword.text,
      );
      final res = await services.login(_context, payload);
      if (res != null && _context.mounted) {
        await Cache.setString(Constant.userID, "${res.id}");
        if (_context.mounted) {
          Navigator.pushAndRemoveUntil(
            _context,
            MaterialPageRoute(
              builder: (context) => ProfileView(
                userID: res.id,
              ),
            ),
            (route) => false,
          );
        }
      }
    }
  }

  Future<void> _initial() async {
    final userID = await Cache.getString(Constant.userID);
    final userIDAsInt = int.tryParse(userID);
    if (userIDAsInt != null && _context.mounted) {
      Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
          builder: (context) => ProfileView(
            userID: userIDAsInt,
          ),
        ),
        (route) => false,
      );
    }
  }
}
