import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/screens/cart_page.dart';
import 'package:ecommerceapp/service/api_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerceapp/model/shop_model.dart';
import 'dart:ui';

class Description extends StatefulWidget {
  final int id;
  final String itemName;
  final String itemPrice;
  final String imagepath;
  final String color;
  final String itemdescription;
  final int rating;
  final int user_id;
  final int item_id;

  const Description({
    Key? key,
    required this.item_id,
    required this.id,
    required this.itemName,
    required this.itemPrice,
    required this.imagepath,
    required this.color,
    required this.itemdescription,
    required this.rating,
    required this.user_id
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  double _rating = 0.0;
  bool _isLoading = true;
  bool _isProcessingPurchase = false;

  @override
  void initState() {
    print("itemid");
    print(widget.item_id);
    super.initState();
    ApiService().visitItem(widget.item_id);
    _loadRating();
  }

  void _confirmPurchase() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Purchase"),
        content: const Text("Are you sure you want to buy this product?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel action
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _startPurchaseProcess();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text("Buy"),
          ),
        ],
      ),
    );
  }

  void _startPurchaseProcess() {
    setState(() {
      _isProcessingPurchase = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isProcessingPurchase = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Purchase successful!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _loadRating() async {
    try {
      List<RatingModel> ratingsList = await ApiService().ratings();
      RatingModel? shopRating = ratingsList.firstWhere(
        (r) => r.shopItem == widget.id,
        orElse: () => RatingModel(id: 0, rating: 0, shopItem: widget.id),
      );

      if (mounted) {
        setState(() {
          _rating = shopRating.rating.toDouble();
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching rating: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.itemName),
            backgroundColor: Colors.teal,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildProductDetailsCard(),
                  const SizedBox(height: 30),
                  RecommendationSection(itemId: widget.id, user_id: widget.user_id),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            backgroundColor: Colors.black,
            child: const Icon(Icons.shopping_bag, color: Colors.white),
          ),
        ),
        
        // Show Loader with Blur Effect if Processing Purchase
        if (_isProcessingPurchase)
          Positioned.fill(
            child: Stack(
              children: [
                // Blur Effect
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                // Loading Indicator
                const Center(
                  child: CircularProgressIndicator(color: Colors.teal, strokeWidth: 6),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildProductDetailsCard() {
    return Card(
      color: _getColorFromString(widget.color).withOpacity(0.51),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imagepath,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 250, color: Colors.grey);
                    },
                  ),
                ),
                Text(
                  widget.itemName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'Rs ${widget.itemPrice}',
                  style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.itemdescription,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Center(
              child:RatingBar.builder(
  ignoreGestures: true, // Disables user input
  initialRating: widget.rating.toDouble(), // Use widget.rating
  minRating: 0,
  direction: Axis.horizontal,
  itemCount: 5,
  allowHalfRating: true,
  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
  onRatingUpdate: (rating) {},
),
 ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _confirmPurchase,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.teal,
                  elevation: 5,
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'pink':
        return Colors.pink;
      case 'yellow':
        return Colors.yellow;
      case 'brown':
        return Colors.brown;
      case 'purple':
        return Colors.purple;
      case 'black':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }
}
class RecommendationSection extends StatelessWidget {
  final int itemId;
  final int user_id;

  const RecommendationSection({Key? key, required this.itemId, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(itemId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            "Recommended for You",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        FutureBuilder<List<Recommendation>>(
          future: ApiService().fetchRecommendations(itemId,user_id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text("No recommendations available")),
              );
            } else {
              return SizedBox(
                height: 200, // Fixed height for the horizontal scroll
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];
                    return _buildRecommendationCard(item);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  /// Loading shimmer effect while fetching recommendations
  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  /// Card UI for each recommended item
  Widget _buildRecommendationCard(Recommendation item) {
    return Container(
      width: 150, // Adjust width for a compact look
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                // item.imageUrl ??
                 "https://via.placeholder.com/150",
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.score.toStringAsFixed(2)),
                const SizedBox(height: 4),
                // Text(
                //   "\$${item.price?.toStringAsFixed(2) ?? "N/A"}",
                //   style: const TextStyle(
                //     fontSize: 14,
                //     color: Colors.teal,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                const SizedBox(height: 4),
                
                // Row(
                //   children: [
                //     const Icon(Icons.star, color: Colors.amber, size: 18),
                //     const SizedBox(width: 4),
                //     // Text(
                //     //   item.rating?.toStringAsFixed(1) ?? "N/A",
                //     //   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                //     // ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}