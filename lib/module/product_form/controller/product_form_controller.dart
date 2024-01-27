import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String? productName;
  double? price;
  String? category;
  String? description;

  doSave() async {
    ProductService().insertProduct(
      productName: productName!,
      price: price!,
      category: category!,
      description: description!,
    );
    Get.back();
  }
}
