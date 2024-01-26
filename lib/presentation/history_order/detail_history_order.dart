import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/data/models/response/list_order_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(color: GlobalVariables.primaryColor),
            ),
            title: const Text(
              'Detail History Order',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Order Date: ${_formatDate(order.attributes!.createdAt!)}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Harga: ${order.attributes?.totalPrice!.currencyFormatRp}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Order Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        _getUniqueProductsCount(order.attributes!.items!),
                    itemBuilder: (context, index) {
                      final product =
                          _getUniqueProducts(order.attributes!.items!)[index];
                      final List<Item> items = _getItemsForProduct(
                          order.attributes!.items!, product);

                      // Menghitung total kuantitas
                      int totalQty = 0;
                      for (var item in items) {
                        totalQty += item.qty ?? 0;
                      }

                      return Card(
                        child: ListTile(
                          title: Text(items[0].productName ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Produk: $totalQty'),
                              Text(
                                  'Harga: ${items[0].price!.currencyFormatRp}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }

  // Fungsi untuk mendapatkan jumlah produk yang unik
  int _getUniqueProductsCount(List<Item> items) {
    final uniqueProducts = _getUniqueProducts(items);
    return uniqueProducts.length;
  }

  // Fungsi untuk mendapatkan daftar produk yang unik
  List<String> _getUniqueProducts(List<Item> items) {
    Set<String> uniqueProducts = <String>{};
    for (var item in items) {
      if (item.productName != null) {
        uniqueProducts.add(item.productName!);
      }
    }
    return uniqueProducts.toList();
  }

  // Fungsi untuk mendapatkan daftar item yang sesuai dengan suatu produk
  List<Item> _getItemsForProduct(List<Item> items, String product) {
    return items.where((item) => item.productName == product).toList();
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd MMMM y, HH:mm z', 'id_ID');
    return formatter.format(date.add(const Duration(hours: 7)));
  }
}
