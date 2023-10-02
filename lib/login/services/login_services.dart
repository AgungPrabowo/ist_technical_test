import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../../utils/dialog.dart';
import '../model/request_login_model.dart';
import '../model/response_login_model.dart';

class LoginServices extends DialogUtils {
  Future<ResponseLoginModel?> login(
    BuildContext context,
    RequestLoginModel payload,
  ) async {
    showLoading(context);
    final res = await http.post(
      Uri(
        host: Constant.baseUrl,
        path: "/auth/login",
        scheme: "https",
      ),
      body: payload.toJson(),
    );

    if (context.mounted) Navigator.pop(context);
    if (res.statusCode == 200) {
      return responseLoginModelFromJson(res.body);
    } else if (context.mounted) {
      snackBar(
        context,
        jsonDecode(res.body)["message"],
        backgroundColor: Colors.red,
      );
    }
    return null;
  }
}
