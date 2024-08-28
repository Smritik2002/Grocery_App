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
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
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
            Consumer<CartModel>(
              builder: (_, value, __) {
                return Positioned(
                  right: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        "${value.cartItems.length}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: SearchBar(
                  leading: const Icon(Icons.search_outlined),
                  textInputAction: TextInputAction.search,
                  hintText: "Search Your Item Here",
                  onChanged: (value) {
                    Provider.of<CartModel>(context, listen: false)
                        .searchItems(value);
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .sortItemsByPrice(false); // Sort by High Price
                      },
                      child: const Text("Sort by High Price"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .sortItemsByPrice(true); // Sort by Low Price
                      },
                      child: const Text("Sort by Low Price"),
                    ),
                  ],
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Let's order fresh items for you",
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
              Consumer<CartModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      itemCount: value.shopItems.length,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.4,
                      ),
                      itemBuilder: (context, index) {
                        return GroceryItemTile(
                          itemName: value.shopItems[index][0],
                          itemPrice: value.shopItems[index][1],
                          imagepath: value.shopItems[index][2],
                          color: value.shopItems[index][3],
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .addItemsToCart(index);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
