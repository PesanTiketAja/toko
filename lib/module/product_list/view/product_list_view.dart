import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductList"),
        actions: [
          CircleAvatar(
            child: Text(
              "${controller.product.length}",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.product.length,
        padding: const EdgeInsets.all(20.0),
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = controller.product[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
              ),
              title: Text(item["product_name"]),
              subtitle: Text("${item["price"]}"),
              onTap: () => {
                Get.to(ProductFormView(
                  item: item,
                )),
                controller.getProducts()
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(ProductFormView());
          controller.getProducts();
        },
      ),
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
