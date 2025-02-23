import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/food_model.dart';

class CartCard extends StatelessWidget {
  final Dish dish;
  final int quantity;
  final void Function() addOnTap;
  final void Function()? removeOnTap;
  const CartCard({super.key, required this.dish, required this.quantity, required this.addOnTap, this.removeOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 200.w,
                  child: Text(
                    dish.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                    maxLines: 2,
                  )),
              Text('INR ${dish.price} x $quantity'),
              Text('${dish.calories} Calories'),

            ],
          ),
          Container(
            width: 120.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.green.shade400),
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: removeOnTap,
                    child: Icon(Icons.remove)),
                Text(quantity.toString()),
                InkWell(
                    onTap: addOnTap,
                    child: Icon(Icons.add)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
