import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../login/view/login_view.dart';
import '../../utils/cache.dart';
import '../../utils/constant.dart';
import '../model/response_profile_model.dart';
import '../services/profile_services.dart';

class ProfileViewModel extends ChangeNotifier {
  final BuildContext _context;
  final int _userID;
  final services = ProfileServices();
  ResponseProfileModel? dataProfile;
  Uint8List? avatarFile;

  ProfileViewModel(this._context, this._userID) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getProfile();
      },
    );
  }

  void _getProfile() async {
    final res = await services.getProfile(_context, _userID);
    if (res != null) {
      dataProfile = res;
      notifyListeners();
    }
  }

  void logout() async {
    await Cache.removeCache(Constant.userID);
    if (_context.mounted) {
      Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
        (route) => false,
      );
    }
  }

  void pickFile() async {
    final pickFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "jpeg", "png"],
      withData: true,
    );
    if (pickFiles != null && pickFiles.files.isNotEmpty) {
      final pickFile = pickFiles.files.first;
      avatarFile = pickFile.bytes;
      notifyListeners();
    }
  }
}
