import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../../utils/dialog.dart';
import '../model/response_profile_model.dart';

class ProfileServices extends DialogUtils {
  Future<ResponseProfileModel?> getProfile(
    BuildContext context,
    int userID,
  ) async {
    showLoading(context);
    final res = await http.get(
      Uri(
        host: Constant.baseUrl,
        path: "/users/$userID",
        scheme: "https",
      ),
    );
    if (context.mounted) Navigator.pop(context);
    if (res.statusCode == 200) {
      return responseProfileModelFromJson(res.body);
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
