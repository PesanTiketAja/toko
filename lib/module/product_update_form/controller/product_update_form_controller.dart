import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/product_update_form_view.dart';

class ProductUpdateFormController extends State<ProductUpdateFormView> {
  static late ProductUpdateFormController instance;
  late ProductUpdateFormView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
