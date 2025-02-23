import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/food_model.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final void Function() addOnTap;
  final void Function()? removeOnTap;
  final String qundity;
  const DishCard({super.key, required this.dish, required this.addOnTap, required this.removeOnTap, required this.qundity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(dish.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                      ),),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text('INR ${dish.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                      ),),
                  ),

                ],
              ),
              Spacer(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${dish.calories.toString()} Calories",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 14.sp),),
                  SizedBox(width: 5,),
                  Image.network(
                    dish.imageUrl,
                    width: 70.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(width: 10.w,),
            ],
          ),
          SizedBox(height: 10.h,),

          SizedBox(
              width: 280.w,
              child: Text(dish.description,
                style: TextStyle(
                    fontSize: 14.sp ,
                    color: Colors.grey
                ),)),

          Container(
            width: 120.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.green.shade400
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: removeOnTap,
                    child: Icon(Icons.remove)),
                Text('$qundity'),
                InkWell(
                    onTap: addOnTap,
                    child: Icon(Icons.add)),
              ],
            ),
          ),
          SizedBox(height: 10,),
          if (dish.customizationsAvailable)
            SizedBox(
                width: 200.w,
                child: Text('Customizations available',
                    style: TextStyle(color: Colors.red,
                        fontSize: 12.sp))),

        ],
      ),
    );
  }
}
