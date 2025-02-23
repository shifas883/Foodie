class Category {
  final int id;
  final String name;
  final List<Dish> dishes;

  Category({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      dishes: List<Dish>.from(json['dishes'].map((dish) => Dish.fromJson(dish))),
    );
  }
}

class Dish {
  final int id;
  final String name;
  final String price;
  final String currency;
  final int calories;
  final String description;
  final List<Addon> addons;
  final String imageUrl;
  final bool customizationsAvailable;
  final bool isVeg;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.addons,
    required this.imageUrl,
    required this.customizationsAvailable,
    required this.isVeg,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      calories: json['calories'],
      description: json['description'],
      addons: List<Addon>.from(json['addons'].map((addon) => Addon.fromJson(addon))),
      imageUrl: json['image_url'],
      customizationsAvailable: json['customizations_available'],
      isVeg: json['is_veg'],
    );
  }
}

class Addon {
  final int id;
  final String name;
  final String price;

  Addon({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}