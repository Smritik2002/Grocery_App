import 'package:ecommerceapp/screens/description.dart';
import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final int id;
  final String itemName;
  final String itemPrice;
  final String imagepath;
  final String color;
  final int rating;
  final Function() onPressed;
  final String itemdescription;
  final int user_id;

  const GroceryItemTile({
    super.key,
    required this.id,
    required this.itemName,
    required this.itemPrice,
    required this.imagepath,
    required this.color,
    required this.onPressed,
    required this.itemdescription,
    required this.rating,
    required this.user_id,
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
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(0.2),
          decoration: BoxDecoration(
            color: _getColorFromString(color), 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                imagepath,
                height: 99,
              ),
              Text(itemName),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: MaterialButton(
                  onPressed: onPressed,
                  child: Text(
                    'Rs $itemPrice',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: (){
          print("Item id is $id");
          print("User id is $user_id");
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Description(
            user_id: user_id,
            item_id:id,
            color: color, itemName: itemName, itemPrice: itemPrice, imagepath: imagepath,
          rating:rating,
           id: id
          , itemdescription: itemdescription,)));
        },
      ),
    );
  }
}
