import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/providers/menu_sevice.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/dish_card.dart';
import '../widgets/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInitialized = false;
  int _selectedCategoryIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<MenuProvider>(context, listen: false).fetchMenu();
      _isInitialized = true;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    if (menuProvider.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (menuProvider.categories.isEmpty) {
      return Scaffold(body: Center(child: Text('No menu items available')));
    }

    final categories = menuProvider.categories;
    final selectedCategory = categories[_selectedCategoryIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, "/checkout");
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.items.isNotEmpty
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              cart.items.length.toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isSelected = _selectedCategoryIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                isSelected ? Colors.red.shade700 : Colors.black,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: isSelected ? 100 : 0,
                        height: 3,
                        color: isSelected
                            ? Colors.red.shade700
                            : Colors.transparent,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 25),
              separatorBuilder: (context, index) => Divider(),
              itemCount: selectedCategory.dishes.length,
              itemBuilder: (context, dishIndex) {
                final dish = selectedCategory.dishes[dishIndex];
                final int quantity = cartProvider.getQuantity(dish);

                return DishCard(
                  dish: dish,
                  addOnTap: () {
                    cartProvider.addToCart(dish);
                  },
                  removeOnTap: quantity > 0
                      ? () {
                          cartProvider.decreaseQuantity(dish);
                        }
                      : null,
                  qundity: quantity.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
