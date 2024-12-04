import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagepath;
  final String color;
  final Function() onPressed;

  const GroceryItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagepath,
    required this.color,
    required this.onPressed,
  });

  Color _getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
        case "yellow":
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'purple':
      return Colors.purple;  
      case 'redAccent':
        return Colors.redAccent;
        case 'pink':
        return Colors.pink;
      case 'blueAccent':  
        return Colors.blueAccent;
      default:
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(0.2),
        decoration: BoxDecoration(
          color: _getColorFromString(color), // Use the function to get Color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagepath,
              height: 94,
            ),
            Text(itemName),
            MaterialButton(
              onPressed: onPressed,
              child: Text(
                '\$$itemPrice',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
