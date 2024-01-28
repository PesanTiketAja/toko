import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      productName = widget.item!["product_name"];
      price = double.parse(widget.item!["price"].toString());
      category = widget.item!["category"];
      description = widget.item!["description"];
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool get isEditMode => widget.item != null;

  String? productName;
  double? price;
  String? category;
  String? description;

  doSave() async {
    if (isEditMode) {
      await ProductService().updateProduct(
        id: widget.item!["id"],
        productName: productName!,
        price: price!,
        category: category!,
        description: description!,
      );
    } else {
      await ProductService().insertProduct(
        productName: productName!,
        price: price!,
        category: category!,
        description: description!,
      );
    }
    Get.back();
  }
}
