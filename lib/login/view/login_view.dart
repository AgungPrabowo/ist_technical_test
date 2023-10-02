import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => LoginViewModel(context),
        child: Consumer<LoginViewModel>(
          builder: (context, provider, _) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary.withOpacity(.5),
                    Theme.of(context).colorScheme.inversePrimary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: provider.ctrlUsername,
                          decoration: const InputDecoration(
                            label: Text("Username"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username mohon diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: provider.ctrlPassword,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                provider.toggleVisibility();
                              },
                              child: Icon(
                                provider.showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: !provider.showPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password mohon diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => provider.onSubmit(),
                          child: const Text("Login"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
