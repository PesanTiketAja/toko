import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductFormView extends StatefulWidget {
  final Map? item;
  ProductFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  _ProductFormViewState createState() => _ProductFormViewState();

  build(BuildContext context, ProductFormController productFormController) {}
}

class _ProductFormViewState extends State<ProductFormView> {
  late ProductFormController controller;

  @override
  Widget build(BuildContext context) {
    controller = ProductFormController();

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
                {"label": "Bahan Baku", "value": "Bahan Baku"},
                {"label": "Sembako", "value": "Sembako"},
              ],
              value: null,
              onChanged: (value, label) {
                controller.category = label;
              },
            ),
            QMemoField(
              label: "Deskripsi Produk",
              validator: Validator.required,
              value: null,
              onChanged: (value) {
                controller.description = value;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: QActionButton(
        label: "Tambah Produk",
        onPressed: () => controller.doSave(),
      ),
    );
  }
}
