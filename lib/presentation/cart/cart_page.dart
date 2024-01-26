import 'package:fashiondome/bloc/checkout/checkout_bloc.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/presentation/auth/login_page.dart';
import 'package:fashiondome/presentation/checkout/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/global_variables.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int page = 2;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(color: GlobalVariables.primaryColor),
            ),
            centerTitle: true,
            title: const Text(
              "Keranjang",
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Subtotal ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutLoaded) {
                      final total = state.items.fold(
                          0, (sum, item) => sum + item.attributes!.price!);
                      return Text(
                        total.currencyFormatRp,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return const Text(
                      'calculate',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final isLogin = await AuthLocalDatasource().isLogin();
                if (isLogin) {
                  if (context.mounted) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CheckoutPage();
                    }));
                  }
                } else {
                  if (context.mounted) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: GlobalVariables.primaryColor,
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                final uniqueItem = state.items.toSet().length;
                final dataSet = state.items.toSet();
                return Expanded(
                  child: ListView.builder(
                    itemCount: uniqueItem,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    dataSet.elementAt(index).attributes!.image!,
                                    fit: BoxFit.fitWidth,
                                    height: 135,
                                    width: 135,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '${dataSet.elementAt(index).attributes!.name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          dataSet
                                              .elementAt(index)
                                              .attributes!
                                              .price!
                                              .currencyFormatRp,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                            '${dataSet.elementAt(index).attributes!.description!.length >= 20 ? dataSet.elementAt(index).attributes!.description!.substring(0, 20) : dataSet.elementAt(index).attributes!.description!}....'),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: const Text(
                                          'In Stock',
                                          style: TextStyle(
                                            color: Colors.teal,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                RemoveFromCartEvent(
                                                    product: dataSet
                                                        .elementAt(index)));
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.5),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: BlocBuilder<CheckoutBloc,
                                                CheckoutState>(
                                              builder: (context, state) {
                                                if (state is CheckoutLoaded) {
                                                  final countItem = state.items
                                                      .where((element) =>
                                                          element.id ==
                                                          dataSet
                                                              .elementAt(index)
                                                              .id)
                                                      .length;
                                                  return Text('$countItem');
                                                }
                                                return const Text('0');
                                              },
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                AddToCartEvent(
                                                    product: dataSet
                                                        .elementAt(index)));
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
