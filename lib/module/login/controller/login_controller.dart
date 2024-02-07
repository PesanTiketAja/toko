import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

    bool isPasswordObscure = true;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  @override
  void initState() {
    instance = this;
    super.initState();
    bool obscurePassword = true;

  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  doLogin() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showLoading();
    bool isSucces =
        await AuthService().login(email: email!, password: password!);

    hideLoading();

    if (!isSucces) {
      showInfoDialog("Password atau Email Kamu salah kayanya deh");
      return;
    }
    Get.offAll(MainNavigationView());
  }
}

