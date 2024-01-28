import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductFormView extends StatefulWidget {
  final Map? item;
  ProductFormView({
    Key? key,
    this.item,
  }) : super(key: key);
  

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            QTextField(
              label: "Nama Produk",
              validator: Validator.required,
              value: controller.productName,
              onChanged: (value) {
                controller.productName = value;
              },
            ),
            QNumberField(
              label: "Harga Produk",
              validator: Validator.required,
              value: controller.price?.toString(),
              onChanged: (value) {
                controller.price = double.tryParse(value) ?? 0.0;
              },
            ),
            QDropdownField(
              label: "Kategori Produk",
              validator: Validator.required,
              items: [
                {"label": "Bahan Baku", 
                "value": "Bahan Baku"
                },
                {"label": "Sembako", 
                "value": "Sembako"
                },
              ],
              value: null,
              onChanged: (value, label) {
                controller.category = label;
              },
            ),
            QMemoField(
              label: "Deskripsi Produk",
              validator: Validator.required,
              value: controller.description,
              onChanged: (value) {
                controller.description = value;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: QActionButton(
        label: "save",
        onPressed: () => controller.doSave(),
      ),
    );
  }

  // @Override
  State<ProductFormView>createState() => ProductFormController();
}


