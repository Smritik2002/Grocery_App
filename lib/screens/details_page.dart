  import 'package:ecommerceapp/components/grocery_item_tile.dart';
  import 'package:ecommerceapp/model/cart_model.dart';
  import 'package:ecommerceapp/model/shop_model.dart';
  import 'package:ecommerceapp/screens/cart_page.dart';
  import 'package:ecommerceapp/service/api_service.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  class DetailsPage extends StatefulWidget {
    final int userId;
    const DetailsPage({super.key,required this.userId});

    @override
    State<DetailsPage> createState() => _DetailsPageState();
  }

  class _DetailsPageState extends State<DetailsPage> {
    late Future<List<ShopItem>> _futureShopItems;

    @override
    void initState() {
      super.initState();
      _futureShopItems = ApiService().getShopItems();
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text("Shop"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality here
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "E-Commerce App",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Navigate to Profile page
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
          
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: FutureBuilder<List<ShopItem>>(
              future: _futureShopItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }
                final shopItems = snapshot.data!;
                return GridView.builder(
                  itemCount: shopItems.length,
                  padding: const EdgeInsets.all(2),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = shopItems[index];
                    return GroceryItemTile(
                      id : item.id,
                      itemdescription: item.description,
                      itemName: item.name,
                      itemPrice: item.price.toString(),
                      imagepath: item.image,
                      color: item.color,
                      rating: item.rating,
                      user_id: widget.userId,
                      
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addItemsToCart(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    }
  }