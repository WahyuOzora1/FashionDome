import 'package:fashiondome/bloc/order/order_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/common/snap_widget.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/data/models/request/order_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/checkout/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.local_shipping),
                SizedBox(
                  width: 5,
                ),
                Text('Alamat Pengiriman'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                  labelText: '', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                Icon(Icons.add_chart_rounded),
                SizedBox(
                  width: 5,
                ),
                Text('Product Item'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  final uniqueItem = state.items.toSet().length;
                  final dataSet = state.items.toSet();
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final count = state.items
                            .where(
                              (element) =>
                                  element.id == dataSet.elementAt(index).id,
                            )
                            .length;
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(dataSet
                                    .elementAt(index)
                                    .attributes!
                                    .image!)),
                            title: Text(
                              dataSet.elementAt(index).attributes!.name!,
                              style: const TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              dataSet
                                  .elementAt(index)
                                  .attributes!
                                  .price!
                                  .currencyFormatRp,
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Text('$count x'),
                          ),
                        );
                      },
                      itemCount: uniqueItem,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        color: GlobalVariables.primaryColor,
                        child: const Text('ok'),
                      );
                    },
                    itemCount: 0,
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (model) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SnapWidget(url: model.redirectUrl);
                }));
              },
            );
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor),
                  onPressed: () async {
                    final userId = await AuthLocalDatasource().getUserId();
                    final total = state.items
                        .fold(0, (sum, item) => sum + item.attributes!.price!);
                    final data = Data(
                      items: state.items
                          .map((e) => Item(
                              id: e.id!,
                              productName: e.attributes!.name!,
                              price: e.attributes!.price!,
                              qty: 1))
                          .toList(),
                      totalPrice: total,
                      deliveryAddress: addressController.text,
                      courierName: 'JNE',
                      shippingCost: 22000,
                      statusOrder: 'waitingPayment',
                      userId: userId,
                    );
                    final requestModel = OrderRequestModel(data: data);
                    final currentState = state;
                    currentState.items.clear();
                    if (context.mounted) {
                      context
                          .read<OrderBloc>()
                          .add(OrderEvent.doOrder(requestModel));
                    }
                  },
                  child: const Text(
                    'Bayar',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
