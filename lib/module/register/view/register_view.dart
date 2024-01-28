import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  Widget build(context, RegisterController controller) {
    controller.view = this;
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
                  // suffixIcon: Icons.name,
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
                  obscure: true,
                  validator: Validator.required,
                  suffixIcon: Icons.password,
                  onChanged: (value) {
                    controller.password = value;
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

  @override
  State<RegisterView> createState() => RegisterController();
}

