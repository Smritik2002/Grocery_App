import 'package:ecommerceapp/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Description extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String imagepath;
  final String color;
  final String itemdescription;

  const Description({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagepath,
    required this.color,
    required this.itemdescription,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              // Product Details Card
              _buildProductDetailsCard(),
              const SizedBox(height: 30),

              // Recommendation Section
              const RecommendationSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProductDetailsCard() {
    return Card(
      color: _getColorFromString(widget.color).withOpacity(0.51),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.itemName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                Text(
                  '\$${widget.itemPrice}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            const Divider(
              thickness: 2.2,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 8),
            Text(
              widget.itemdescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // Buy Now Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print('Rating: $rating');
                },
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
      case 'black':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }
}

// Recommendation Section Widget
class RecommendationSection extends StatelessWidget {
  const RecommendationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Recommendations",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
         SizedBox(height: 10),

        // Placeholder for recommendations
       
      ],
    );
  }
}
