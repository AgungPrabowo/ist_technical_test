import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/show_image.dart';
import '../view_model/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final int userID;
  const ProfileView({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    Widget textItem(String key, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget buildAvatar(String image) {
      return Consumer<ProfileViewModel>(builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => provider.pickFile(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: ShowImage(
                image: provider.avatarFile ?? image,
                loadingWidget: const SizedBox(),
              ),
            ),
          ),
        );
      });
    }

    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(context, userID),
      child: Consumer<ProfileViewModel>(
        builder: (context, provider, _) {
          final data = provider.dataProfile;
          return WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("User Profile"),
                actions: [
                  GestureDetector(
                    child: const Icon(Icons.logout),
                    onTap: () {
                      provider.logout();
                    },
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: data != null
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              children: [
                                buildAvatar(data.image),
                                const SizedBox(height: 32),
                                textItem(
                                  "Full Name",
                                  "${data.firstName} ${data.lastName}",
                                ),
                                textItem("Age", "${data.age}"),
                                textItem("Gender", data.gender),
                                textItem("Username", data.username),
                                textItem("Email", data.email),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
            onWillPop: () async => false,
          );
        },
      ),
    );
  }
}
