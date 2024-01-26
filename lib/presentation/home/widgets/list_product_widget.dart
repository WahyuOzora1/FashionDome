import 'package:fashiondome/bloc/checkout/checkout_bloc.dart';
import 'package:fashiondome/bloc/get_products/get_products_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/data/models/response/list_product_response_model.dart';
import 'package:fashiondome/presentation/home/detail_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetProductsError) {
          return const Center(
            child: Text('Data error'),
          );
        }

        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text('Data Empty'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75),
            itemBuilder: (BuildContext context, int index) {
              final Product product = state.data.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailProductPage(product: product);
                  }));
                },
                child: Card(
                  elevation: 2,
                  shadowColor: GlobalVariables.primaryColor,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    color: Colors.white,
                    height: double.infinity, // Set height to maximum possible
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 216, 227, 236),
                                width: 7),
                          ),
                          child: Hero(
                            tag: product.attributes!.image!,
                            child: SizedBox(
                              width: 150,
                              height: 120,
                              child: Image.network(product.attributes!.image!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              product.attributes!.name!,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.attributes!.price!.currencyFormatRp,
                                style: const TextStyle(
                                  color: GlobalVariables.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<CheckoutBloc>()
                                      .add(AddToCartEvent(product: product));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: GlobalVariables.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0,
                                            3), // Offset untuk memberikan efek shadow ke arah bawah
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: state.data.data!.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
