import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView> {
  static late ProductListController instance;
  late ProductListView view;

  get searchController => null;

  @override
  void initState() {
    instance = this;
    getProducts();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    // Add your build logic here
    return widget.build(context, this);
  }

  List product = [];
  getProducts() async {
    product = await ProductService().getProduct();
    setState(() {});
  }

  doDelete(int id) async {
    await ProductService().deleteProduct(id);
    getProducts();
  }

  void searchProducts() {}
}
