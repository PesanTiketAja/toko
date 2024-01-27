import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductListController extends State<ProductListView> {
  static late ProductListController instance;
  late ProductListView view;

  @override
  void initState() {
    instance = this;
    getProducts();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List product = [];
  getProducts() async {
    product = await ProductService().getProduct();
    setState(() {});
  }
}
