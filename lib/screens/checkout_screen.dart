import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/cart_card.dart';
import '../utils/common_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    double grandTotal = cartItems.entries.fold(0, (sum, entry) {
      double price = double.tryParse(entry.key.price) ?? 0;
      return sum + (price * entry.value);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade900,
        surfaceTintColor: Colors.blue.shade900,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in cart'))
          : Container(
        margin:
        EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 200.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
          Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(5),),
            child: Center(
              child: Text(
                '${cartItems.length} Dishes - ${cartItems.length} Items',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 380.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final dish = cartItems.keys.elementAt(index);
                final quantity = cartItems[dish]!;

                return CartCard(
                  dish: dish,
                  quantity: quantity,
                  removeOnTap: () =>
                      cartProvider.decreaseQuantity(dish),
                  addOnTap: () =>
                      cartProvider.addToCart(dish),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount:',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Text('INR $grandTotal',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold,color: Colors.green)),
              ],
            ),
          ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          margin: EdgeInsets.only(left: 35),
          child: ConfirmButton(
              text: 'Place Order',
              onTap: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed successfully!')),
                );
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}