import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shecker_partners/provider/theme_provider.dart';
import 'package:shecker_partners/core/theme/global_colors.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flareline_uikit/components/card/common_card.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key});

  // Future<List<Order>> fetchOrders() async {
  //   final response = await http.get(Uri.parse('https://www.shecker-admin.com/api/order/detail/'));
  //
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((order) => Order.fromJson(order)).toList();
  //   } else {
  //     throw Exception('Failed to load orders');
  //   }
  // }

  Future<Fridge> fetchOrders(int id) async {
    final response = await http.get(Uri.parse('https://www.shecker-admin.com/api/fridge/admin/$id'));

    if (response.statusCode == 200) {
      return Fridge.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load fridge');
    }
  }

  Future<Sale> fetchSalesData() async {
    // List<Order> orders = await fetchOrders();
    double totalSales = 0;
    int totalOrders = 0;
    Set<String> fridges = Set<String>();

    // for (var order in orders) {
    //   if (order.status == 'SUCCESS') {
    //     Fridge fridge = await fetchFridge(int.parse(order.fridgeId));
    //     fridges.add(order.fridgeId);
    //     for (var fridgeProduct in fridge.fridgeProducts) {
    //       totalSales += fridgeProduct.product.price * fridgeProduct.quantity;
    //       totalOrders += fridgeProduct.quantity;
    //     }
    //   }
    // }

    return Sale(totalSales: totalSales, totalOrders: totalOrders, totalFridges: fridges.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sale>(
      future: fetchSalesData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ScreenTypeLayout.builder(
            desktop: (context) => contentDesktopWidget(context, snapshot.data!),
            mobile: (context) => contentMobileWidget(context, snapshot.data!),
            tablet: (context) => contentMobileWidget(context, snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget contentDesktopWidget(BuildContext context, Sale sale) {
    return Row(
      children: [
        Expanded(
            child: _itemCardWidget(context, Icons.data_object, '\$${sale.totalSales}',
                AppLocalizations.of(context)!.totalViews, '0.43%', true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _itemCardWidget(context, Icons.shopping_cart, '${sale.totalOrders}',
                AppLocalizations.of(context)!.totalProfit, '0.43%', true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _itemCardWidget(context, Icons.group, '${sale.totalFridges}',
                AppLocalizations.of(context)!.totalProduct, '0.43%', true)),
      ],
    );
  }

  Widget contentMobileWidget(BuildContext context, Sale sale) {
    return Column(
      children: [
        // _itemCardWidget(context, Icons.data_object, '\$${sale.totalSales}',
        //     AppLocalizations.of(context)!.totalViews, '0.43%', true),
        const SizedBox(
          height: 16,
        ),
        // _itemCardWidget(context, Icons.shopping_cart, '${sale.totalOrders}',
        //     AppLocalizations.of(context)!.totalProfit, '0.43%', true),
        const SizedBox(
          height: 16,
        ),
        _itemCardWidget(context, Icons.group, '${sale.totalFridges}',
            AppLocalizations.of(context)!.totalProduct, '0.43%', true),
      ],
    );
  }

  Widget _itemCardWidget(BuildContext context, IconData icons, String text,
      String subTitle, String percentText, bool isGrow) {
    return CommonCard(
      height: 154,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: Icon(
                  icons,
                  color: GlobalColors.sideBar,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  subTitle,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  percentText,
                  style: TextStyle(
                      fontSize: 10,
                      color: isGrow ? Colors.green : Colors.lightBlue),
                ),
                const SizedBox(
                  width: 3,
                ),
                Icon(
                  isGrow ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isGrow ? Colors.green : Colors.lightBlue,
                  size: 12,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Sale {
  final double totalSales;
  final int totalOrders;
  final int totalFridges;

  Sale({required this.totalSales, required this.totalOrders, required this.totalFridges});

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      totalSales: json['totalSales'],
      totalOrders: json['totalOrders'],
      totalFridges: json['totalFridges'],
    );
  }
}

class Order {
  final int id;
  final String status;
  final String fridgeId;
  final String date;

  Order({required this.id, required this.status, required this.fridgeId, required this.date});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      fridgeId: json['fridge_id'],
      date: json['date'],
    );
  }
}

class Fridge {
  final String account;
  final String description;
  final String address;
  final List<FridgeProduct> fridgeProducts;

  Fridge({required this.account, required this.description, required this.address, required this.fridgeProducts});

  factory Fridge.fromJson(Map<String, dynamic> json) {
    var list = json['fridge_products'] as List;
    List<FridgeProduct> productsList = list.map((i) => FridgeProduct.fromJson(i)).toList();

    return Fridge(
      account: json['account'],
      description: json['description'],
      address: json['address'],
      fridgeProducts: productsList,
    );
  }
}

class FridgeProduct {
  final int id;
  final int quantity;
  final Product product;

  FridgeProduct({required this.id, required this.quantity, required this.product});

  factory FridgeProduct.fromJson(Map<String, dynamic> json) {
    return FridgeProduct(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;

  Product({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
