import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/register_view.dart';

class RegisterController extends State<RegisterView> {
  static late RegisterController instance;
  late RegisterView view;

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

  String? name;
  String? email;
  String? password;

  doRegister() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showLoading();
    bool isSucces =
        await AuthService1().register(name: name!, email: email!, password: password!);

    hideLoading();

    if (!isSucces) {
      showInfoDialog("Password atau Email Kamu salah kayanya deh");
      return;
    }
    Get.offAll(LoginView());
  }
}
