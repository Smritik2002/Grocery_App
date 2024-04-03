import 'package:ecommerceapp/components/grocery_item_tile.dart';
import 'package:ecommerceapp/model/cart_model.dart';
import 'package:ecommerceapp/screens/cart_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const CartPage();
              },
            )),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 65,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Good morning",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Let's order fresh items for you ",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Fresh items",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                      itemCount: value.shopItems.length,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.4,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("hello");
                            Provider.of<CartModel>(context, listen: false)
                                .addItemsToCart(index);
                          },
                          child: GroceryItemTile(
                            itemName: value.shopItems[index][0],
                            itemPrice: value.shopItems[index][1],
                            imagepath: value.shopItems[index][2],
                            color: value.shopItems[index][3],
                            onPressed: () {
                              // print("hello");
                              // Provider.of<CartModel>(context, listen: false)
                              //     .addItemsToCart(index);
                            },
                          ),
                        );
                      });
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
