import 'package:ecommerceapp/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'My Cart ',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Consumer<CartModel>(builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: value.cartItems.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              leading: Image.asset(
                                value.cartItems[index][2],
                                height: 38,
                              ),
                              title: Text(
                                value.cartItems[index][0],
                              ),
                              subtitle: Text('\$' + value.cartItems[index][1]),
                              trailing: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () => Provider.of<CartModel>(context,
                                        listen: false)
                                    .removeItemsFromCart(index),
                              ),
                            ),
                          ),
                        );
                      })),
              Container(
                height: 85,
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Text(
                      '\$' + value.calculateTotal(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
