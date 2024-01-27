import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/product_update_form_controller.dart';

class ProductUpdateFormView extends StatefulWidget {
  const ProductUpdateFormView({Key? key}) : super(key: key);

  Widget build(context, ProductUpdateFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductUpdateForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }

  @override
  State<ProductUpdateFormView> createState() => ProductUpdateFormController();
}
