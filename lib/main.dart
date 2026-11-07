
import 'package:flutter/material.dart';

void main() {
  runApp(const TummyTurnApp());
}

// ================= COLOURS =================

const orange = Color(0xFFF47728); // Rich tangerine for Customer
const peach = Color(0xFFFFF1C7);  // Butter yellow surface
const green = Color(0xFF91A83E);  // Deeper matcha for Food Donor
const lavender = Color(0xFFB99AD8); // Richer lavender for NGO / Volunteer
const sky = Color(0xFFD9ECFA);    // Light sky blue for headings
const pink = Color(0xFFE87591);   // Stronger accent
const chocolate = Color(0xFF3D281D);
const cream = Color(0xFFFFF5D9);  // Soft butter background

// ================= APP =================

class TummyTurnApp extends StatelessWidget {
  const TummyTurnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TummyTurn',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: orange),
        scaffoldBackgroundColor: cream,
        fontFamily: 'Arial',
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ================= DONATION MODEL =================

class Donation {
  final int id;
  final String foodName;
  final String quantity;
  final String expiry;
  final String address;
  String status;
  String? requestedBy;

  Donation({
    required this.id,
    required this.foodName,
    required this.quantity,
    required this.expiry,
    required this.address,
    this.status = 'Available',
  });
}

// Shared demo data for donor and NGO dashboards.
final List<Donation> donations = [];
int nextDonationId = 1;

// ================= HOME SCREEN =================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void openRole(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => role == 'Customer'
            ? const CustomerDashboard()
            : RoleDashboard(role: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.restaurant, color: orange, size: 30),
            SizedBox(width: 10),
            Text(
              'TummyTurn',
              style: TextStyle(
                color: chocolate,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'Good food. Good cause.',
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(38),
                  decoration: BoxDecoration(
                    color: peach,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: orange,
                        child: Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Welcome to TummyTurn!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: chocolate,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Order Smart. Share More. Waste Less.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          color: green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Delicious food for you. A helping hand for someone else.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: chocolate),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 38),
                const Text(
                  'Choose Your Experience',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: chocolate,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Select how you would like to use TummyTurn.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth < 650
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 32) / 3;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        RoleCard(
                          width: width,
                          icon: Icons.shopping_bag_outlined,
                          title: 'Customer',
                          description:
                              'Explore restaurants, order delicious food and track your orders.',
                          buttonText: 'Continue as Customer',
                          color: orange,
                          lightColor: peach,
                          onTap: () => openRole(context, 'Customer'),
                        ),
                        RoleCard(
                          width: width,
                          icon: Icons.volunteer_activism,
                          title: 'Food Donor',
                          description:
                              'Share surplus food and help people in need.',
                          buttonText: 'Continue as Donor',
                          color: green,
                          lightColor: const Color(0xFFE2F0E5),
                          onTap: () => openRole(context, 'Food Donor'),
                        ),
                        RoleCard(
                          width: width,
                          icon: Icons.groups_outlined,
                          title: 'NGO / Volunteer',
                          description:
                              'Discover food donations and coordinate collection.',
                          buttonText: 'Continue as NGO',
                          color: lavender,
                          lightColor: sky,
                          onTap: () => openRole(context, 'NGO / Volunteer'),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 35),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.favorite, color: Colors.white, size: 32),
                      SizedBox(height: 10),
                      Text(
                        'Good food deserves a second chance.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Order what you love. Donate what you can.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ROLE CARD =================

class RoleCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final Color color;
  final Color lightColor;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.width,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.color,
    required this.lightColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: color.withValues(alpha: 0.18),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              color: lightColor,
              child: Icon(icon, size: 52, color: color),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: chocolate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 65,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: Text(buttonText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FOOD MODEL =================

class FoodItem {
  final String id;
  final String name;
  final String category;
  final String restaurant;
  final String description;
  final double price;
  final String image;
  final String emoji;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.restaurant,
    required this.description,
    required this.price,
    required this.image,
    required this.emoji,
  });
}

// ================= CUSTOMER DASHBOARD =================

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final searchController = TextEditingController();
  String selectedCategory = 'All';
  String selectedRestaurant = 'All';
  final Map<String, int> cart = {};

  final categories = [
    'All', 'Biryani', 'Pizza', 'Burgers', 'Desserts', 'Drinks'
  ];

  final restaurants = [
    'All', 'Spice Garden', 'Pizza Palace', 'Burger House', 'Sweet Treats'
  ];

  final List<FoodItem> foods = const [
    FoodItem(
      id: '1', name: 'Chicken Biryani', category: 'Biryani',
      restaurant: 'Spice Garden',
      description: 'Aromatic rice with spicy chicken.',
      price: 220,
      image: 'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=600',
      emoji: '🍛',
    ),
    FoodItem(
      id: '2', name: 'Veg Biryani', category: 'Biryani',
      restaurant: 'Spice Garden',
      description: 'Flavourful rice with fresh vegetables.',
      price: 160,
      image: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600',
      emoji: '🥘',
    ),
    FoodItem(
      id: '3', name: 'Margherita Pizza', category: 'Pizza',
      restaurant: 'Pizza Palace',
      description: 'Classic pizza with cheese and tomato.',
      price: 249,
      image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600',
      emoji: '🍕',
    ),
    FoodItem(
      id: '4', name: 'Farmhouse Pizza', category: 'Pizza',
      restaurant: 'Pizza Palace',
      description: 'Loaded with fresh vegetables and cheese.',
      price: 329,
      image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
      emoji: '🍕',
    ),
    FoodItem(
      id: '5', name: 'Classic Burger', category: 'Burgers',
      restaurant: 'Burger House',
      description: 'Crispy patty with fresh lettuce.',
      price: 149,
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
      emoji: '🍔',
    ),
    FoodItem(
      id: '6', name: 'Cheese Burger', category: 'Burgers',
      restaurant: 'Burger House',
      description: 'Juicy burger with melted cheese.',
      price: 189,
      image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600',
      emoji: '🍔',
    ),
    FoodItem(
      id: '7', name: 'Chocolate Cake', category: 'Desserts',
      restaurant: 'Sweet Treats',
      description: 'Rich and delicious chocolate cake.',
      price: 120,
      image: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
      emoji: '🍰',
    ),
    FoodItem(
      id: '8', name: 'Strawberry Milkshake', category: 'Drinks',
      restaurant: 'Sweet Treats',
      description: 'Creamy milkshake with strawberries.',
      price: 99,
      image: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=600',
      emoji: '🥤',
    ),
  ];

  List<FoodItem> get filteredFoods {
    return foods.where((food) {
      final categoryMatch = selectedCategory == 'All' ||
          food.category == selectedCategory;
      final restaurantMatch = selectedRestaurant == 'All' ||
          food.restaurant == selectedRestaurant;
      final query = searchController.text.toLowerCase();
      final searchMatch = food.name.toLowerCase().contains(query) ||
          food.restaurant.toLowerCase().contains(query) ||
          food.category.toLowerCase().contains(query);
      return categoryMatch && restaurantMatch && searchMatch;
    }).toList();
  }

  int get cartCount =>
      cart.values.fold(0, (total, quantity) => total + quantity);

  double get cartTotal {
    double total = 0;
    for (final food in foods) {
      total += food.price * (cart[food.id] ?? 0);
    }
    return total;
  }

  void addToCart(FoodItem food) {
    setState(() {
      cart[food.id] = (cart[food.id] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${food.name} added to cart'),
        backgroundColor: orange,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void changeQuantity(FoodItem food, int change) {
    setState(() {
      final quantity = (cart[food.id] ?? 0) + change;
      if (quantity <= 0) {
        cart.remove(food.id);
      } else {
        cart[food.id] = quantity;
      }
    });
  }

  void openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, updateSheet) {
            final items = foods
                .where((food) => (cart[food.id] ?? 0) > 0)
                .toList();

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Cart 🛒',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: chocolate,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: items.isEmpty
                          ? const Center(child: Text('Your cart is empty!'))
                          : ListView(
                              children: items.map((food) {
                                final quantity = cart[food.id] ?? 0;
                                return Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(food.name),
                                    subtitle: Text('₹${food.price.toStringAsFixed(0)} each'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            changeQuantity(food, -1);
                                            updateSheet(() {});
                                          },
                                          icon: const Icon(Icons.remove_circle_outline, color: orange),
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          onPressed: () {
                                            changeQuantity(food, 1);
                                            updateSheet(() {});
                                          },
                                          icon: const Icon(Icons.add_circle_outline, color: orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹${cartTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: items.isEmpty
                            ? null
                            : () {
                                final total = cartTotal;
                                Navigator.pop(sheetContext);
                                showDialog(
                                  context: this.context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: const Text('Order Confirmed! 🎉'),
                                    content: Text(
                                      'Your demo order of ₹${total.toStringAsFixed(2)} has been placed successfully.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() => cart.clear());
                                          Navigator.pop(dialogContext);
                                        },
                                        child: const Text('Continue'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text('Place Order'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.restaurant, color: orange),
            SizedBox(width: 8),
            Text(
              'TummyTurn',
              style: TextStyle(color: chocolate, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: openCart,
                icon: const Icon(Icons.shopping_cart_outlined, color: chocolate),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 4,
                  top: 3,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: orange,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hungry? 🍽️',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Discover delicious food near you!',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search food or restaurants...',
                    prefixIcon: const Icon(Icons.search, color: orange),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Food Categories',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: chocolate),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: categories.map((category) {
                    final selected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      selectedColor: orange,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : chocolate,
                        fontWeight: FontWeight.w600,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = category),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Popular Restaurants',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: chocolate),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 95,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurants.map((restaurant) {
                      final selected = selectedRestaurant == restaurant;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => setState(() => selectedRestaurant = restaurant),
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 145,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selected ? orange : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: selected ? orange : const Color(0xFFE8DED4),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  restaurant == 'All' ? Icons.restaurant : Icons.storefront,
                                  color: selected ? Colors.white : orange,
                                  size: 27,
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  restaurant,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected ? Colors.white : chocolate,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  selectedCategory == 'All' ? 'Popular Food Items' : selectedCategory,
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: chocolate),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth > 850
                        ? 3
                        : constraints.maxWidth > 550
                            ? 2
                            : 1;

                    if (filteredFoods.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(35),
                        child: Center(child: Text('No matching food items found.')),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredFoods.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        mainAxisExtent: 335,
                      ),
                      itemBuilder: (context, index) {
                        final food = filteredFoods[index];
                        return FoodCard(food: food, onAdd: () => addToCart(food));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= FOOD CARD =================

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onAdd;

  const FoodCard({super.key, required this.food, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 155,
            width: double.infinity,
            child: Image.network(
              food.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: peach,
                child: Center(
                  child: Text(food.emoji, style: const TextStyle(fontSize: 65)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: chocolate),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    food.restaurant,
                    style: const TextStyle(color: orange, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    food.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${food.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: orange),
                      ),
                      FilledButton.icon(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add, size: 17),
                        label: const Text('Add'),
                        style: FilledButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= DONOR AND NGO DASHBOARDS =================

class RoleDashboard extends StatefulWidget {
  final String role;

  const RoleDashboard({super.key, required this.role});

  @override
  State<RoleDashboard> createState() => _RoleDashboardState();
}

class _RoleDashboardState extends State<RoleDashboard> {
  bool get isDonor => widget.role == 'Food Donor';

  Color get roleColor => isDonor ? green : lavender;

  void refresh() {
    setState(() {});
  }

  Future<void> addDonation() async {
    final foodController = TextEditingController();
    final quantityController = TextEditingController();
    final expiryController = TextEditingController();
    final addressController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('List Surplus Food 🍱'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: foodController,
                decoration: const InputDecoration(
                  labelText: 'Food name',
                  hintText: 'Example: Vegetable Biryani',
                ),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'Example: 10 meals',
                ),
              ),
              TextField(
                controller: expiryController,
                decoration: const InputDecoration(
                  labelText: 'Available until',
                  hintText: 'Example: Today, 8 PM',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Pickup address',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: roleColor),
            onPressed: () {
              if (foodController.text.trim().isEmpty ||
                  quantityController.text.trim().isEmpty ||
                  expiryController.text.trim().isEmpty ||
                  addressController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields.')),
                );
                return;
              }
              Navigator.pop(dialogContext, true);
            },
            child: const Text('Submit Donation'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      setState(() {
        donations.add(
          Donation(
            id: nextDonationId++,
            foodName: foodController.text.trim(),
            quantity: quantityController.text.trim(),
            expiry: expiryController.text.trim(),
            address: addressController.text.trim(),
          ),
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food donation listed successfully!'),
          backgroundColor: green,
        ),
      );
    }

    foodController.dispose();
    quantityController.dispose();
    expiryController.dispose();
    addressController.dispose();
  }

  void updateStatus(Donation donation, String status) {
    setState(() => donation.status = status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Donation status updated to $status')),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Available':
        return green;
      case 'Requested':
        return const Color(0xFFF4D77A);
      case 'Accepted':
        return sky;
      case 'Collected':
        return lavender;
      case 'Cancelled':
        return pink;
      default:
        return chocolate;
    }
  }

  Widget donationCard(Donation donation) {
    final status = donation.status;

    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: sky,
                  child: Icon(Icons.fastfood, color: roleColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    donation.foodName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: chocolate,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor(status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Quantity: ${donation.quantity}'),
            Text('Available until: ${donation.expiry}'),
            Text('Pickup: ${donation.address}'),
            if (donation.requestedBy != null)
              Text('Requested by: ${donation.requestedBy}'),
            const SizedBox(height: 12),

            if (isDonor && status == 'Requested')
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => updateStatus(donation, 'Accepted'),
                      style: FilledButton.styleFrom(backgroundColor: roleColor),
                      child: const Text('Accept Request'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          donation.status = 'Available';
                          donation.requestedBy = null;
                        });
                      },
                      child: const Text('Reject'),
                    ),
                  ),
                ],
              ),

            if (isDonor && status == 'Accepted')
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => updateStatus(donation, 'Collected'),
                  style: FilledButton.styleFrom(backgroundColor: roleColor),
                  child: const Text('Mark as Collected'),
                ),
              ),

            if (isDonor && status == 'Available')
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => updateStatus(donation, 'Cancelled'),
                  icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                  label: const Text('Cancel Donation'),
                ),
              ),

            if (!isDonor && status == 'Available')
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      donation.status = 'Requested';
                      donation.requestedBy = 'NGO / Volunteer';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Donation request sent to donor!'),
                        backgroundColor: green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.volunteer_activism),
                  label: const Text('Request This Donation'),
                  style: FilledButton.styleFrom(backgroundColor: roleColor),
                ),
              ),

            if (!isDonor && status == 'Accepted')
              Text(
                'Your request was accepted. Coordinate the pickup with the donor.',
                style: TextStyle(color: roleColor, fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleDonations = isDonor
        ? donations
        : donations.where((d) => d.status != 'Cancelled').toList();

    final availableCount =
        donations.where((d) => d.status == 'Available').length;
    final requestedCount =
        donations.where((d) => d.status == 'Requested').length;
    final collectedCount =
        donations.where((d) => d.status == 'Collected').length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: roleColor,
        foregroundColor: Colors.white,
        title: Text('${widget.role} Dashboard'),
        actions: [
          IconButton(
            onPressed: refresh,
            tooltip: 'Refresh donations',
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              Text(
                isDonor ? 'Welcome, Food Donor! 🌱' : 'Welcome, Volunteer! 💚',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: chocolate,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isDonor
                    ? 'Share surplus food and make a difference.'
                    : 'Find available food donations and help your community.',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 22),

              // SUMMARY CARDS
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Available',
                      count: '$availableCount',
                      color: green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      title: 'Requested',
                      count: '$requestedCount',
                      color: peach,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      title: 'Collected',
                      count: '$collectedCount',
                      color: lavender,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              if (isDonor)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: addDonation,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('List Surplus Food'),
                    style: FilledButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(17),
                    ),
                  ),
                ),

              const SizedBox(height: 25),
              Text(
                isDonor ? 'My Donations' : 'Available Food Donations',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: chocolate,
                ),
              ),
              const SizedBox(height: 15),

              if (visibleDonations.isEmpty)
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: peach,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isDonor ? Icons.volunteer_activism : Icons.search,
                        size: 45,
                        color: roleColor,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isDonor
                            ? 'You have not listed any donations yet.'
                            : 'No food donations are available right now.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: chocolate),
                      ),
                    ],
                  ),
                )
              else
                ...visibleDonations.map(donationCard),

              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Home'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: roleColor,
                  side: BorderSide(color: roleColor),
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= SUMMARY CARD =================

class SummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
