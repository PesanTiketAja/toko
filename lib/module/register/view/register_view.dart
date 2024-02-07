import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => RegisterController();

  Widget build(BuildContext context, RegisterController controller) {
    bool isPasswordObscure = controller.isPasswordObscure; // Ambil status dari controller

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi"),
        actions: const [],
      ),
      body: Container(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QTextField(
                  label: "Name",
                  validator: Validator.name,
                  onChanged: (value) {
                    controller.name = value;
                  },
                ),
                QTextField(
                  label: "Email",
                  validator: Validator.email,
                  suffixIcon: Icons.email,
                  onChanged: (value) {
                    controller.email = value;
                  },
                ),
                QTextField(
                  label: "Password",
                  obscure: isPasswordObscure, // Gunakan status isPasswordObscure di sini
                  validator: Validator.required,
                  suffixIcon: Icons.password,
                  onChanged: (value) {
                    controller.password = value;
                  },
                ),
                IconButton(
                  icon: Icon(isPasswordObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    controller.togglePasswordVisibility();
                  },
                ),
                QButton(
                  label: "Register",
                  onPressed: () => controller.doRegister(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
