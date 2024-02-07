import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/product_list_controller.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => ProductListController();

  Widget build(context, ProductListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Sembako"),
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.searchProducts();
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          // Static Search Table
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Product Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Description')),
              ],
              rows: controller.product.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item["product_name"])),
                    DataCell(Text("${item["price"]}")),
                    DataCell(Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
          // Dynamic Product List
          Expanded(
            child: ListView.builder(
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${item["price"]}"),
                        SizedBox(height: 4), // Spacer
                        Text(
                          "${item["description"]}", // Menampilkan description
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        bool? confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text(
                                  'Apakah Anda yakin ingin menghapus produk ini?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmDelete ?? false) {
                          await controller.doDelete(item["id"]);
                          controller.getProducts();
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 24.0,
                      ),
                    ),
                    onTap: () async {
                      await Get.to(ProductFormView(
                        item: item,
                      ));
                      controller.getProducts();
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
}
