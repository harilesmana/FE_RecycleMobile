import 'package:flutter/material.dart';
import '../util/colors.dart';
import 'keranjang.dart';

class AcceptedItemsScreen extends StatefulWidget {
  @override
  State<AcceptedItemsScreen> createState() => _AcceptedItemsScreenState();
}

class _AcceptedItemsScreenState extends State<AcceptedItemsScreen> {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Botol plastik bening ukuran kecil",
      "price": "Rp50/Botol",
      "image": "assets/images/bening.png",
      "category": "bening",
      "quantity": 0,
    },
    {
      "name": "Botol plastik bening ukuran sedang",
      "price": "Rp70/Botol",
      "image": "assets/images/bening.png",
      "category": "bening",
      "quantity": 0,
    },
    {
      "name": "Botol plastik bening ukuran besar",
      "price": "Rp100/Botol",
      "image": "assets/images/bening.png",
      "category": "bening",
      "quantity": 0,
    },
    {
      "name": "Botol plastik warna ukuran kecil",
      "price": "Rp24/Botol",
      "image": "assets/images/warna.png",
      "category": "warna",
      "quantity": 0,
    },
    {
      "name": "Botol plastik warna ukuran sedang",
      "price": "Rp44/Botol",
      "image": "assets/images/warna.png",
      "category": "warna",
      "quantity": 0,
    },
    {
      "name": "Botol plastik warna ukuran besar",
      "price": "Rp66/Botol",
      "image": "assets/images/warna.png",
      "category": "warna",
      "quantity": 0,
    },
    {
      "name": "Alumunium",
      "price": "Rp90/Pcs",
      "image": "assets/images/alumunium.png",
      "category": "alumunium",
      "quantity": 0,
    },
  ];

  List<Map<String, dynamic>> cartItems = [];
  String searchText = "";
  String selectedCategory = "all";

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      final index =
      cartItems.indexWhere((cartItem) => cartItem['name'] == item['name']);

      if (index != -1) {
        cartItems[index]['quantity'] += 1;
      } else {
        cartItems.add({...item, 'quantity': 1});
      }

      final mainIndex = items.indexWhere((i) => i['name'] == item['name']);
      if (mainIndex != -1) {
        items[mainIndex]['quantity'] += 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} ditambahkan ke keranjang'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double categoryButtonSize = screenWidth * 0.15; // 15% lebar layar
    double iconSize = categoryButtonSize * 0.5;
    double imageSize = categoryButtonSize * 0.5;

    final filteredItems = items.where((item) {
      final matchSearch = item["name"]
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());
      final matchCategory =
      selectedCategory == "all" ? true : item["category"] == selectedCategory;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        leadingWidth: 70,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back", style: TextStyle(color: Colors.black)),
        ),
        title: const Text('Accepted Items', style: TextStyle(color: Colors.black)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KeranjangScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cartItems
                          .fold<int>(0, (sum, item) => sum + item['quantity'] as int)
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Field
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: TextField(
                onChanged: (value) => setState(() => searchText = value),
                decoration: InputDecoration(
                  hintText: "Search items",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Category Tabs
            SizedBox(
              height: categoryButtonSize + 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                children: [
                  _categoryButtonWithIcon("all", Icons.apps, "Semua",
                      categoryButtonSize, iconSize),
                  _categoryButtonWithImage("bening", "assets/images/bening.png",
                      "Bening", categoryButtonSize, imageSize),
                  _categoryButtonWithImage("warna", "assets/images/warna.png",
                      "Warna", categoryButtonSize, imageSize),
                  _categoryButtonWithImage("alumunium",
                      "assets/images/alumunium.png", "Alumunium",
                      categoryButtonSize, imageSize),
                ],
              ),
            ),

            // Item List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(screenWidth * 0.03),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading:
                      Image.asset(item['image'], width: 40, height: 40),
                      title: Text(
                        item['name'],
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                      subtitle: Text(
                        item['price'],
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color: AppColors.lightPrimaryColor),
                        onPressed: () => _addToCart(item),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: screenHeight * 0.03,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "back",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KeranjangScreen(cartItems: cartItems),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF7C6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black45,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButtonWithIcon(
      String value, IconData icon, String label, double size, double iconSize) {
    bool selected = selectedCategory == value;
    return Padding(
      padding: EdgeInsets.only(right: size * 0.2),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: selected ? AppColors.darkPrimaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? AppColors.darkPrimaryColor : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize,
                  color: selected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: size * 0.1),
            Text(
              label,
              style: TextStyle(
                fontSize: size * 0.18,
                color: selected ? AppColors.darkPrimaryColor : Colors.black,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButtonWithImage(String value, String imagePath, String label,
      double size, double imageSize) {
    bool selected = selectedCategory == value;
    return Padding(
      padding: EdgeInsets.only(right: size * 0.2),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: selected ? AppColors.darkPrimaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? AppColors.darkPrimaryColor : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  color: selected ? Colors.white : null,
                ),
              ),
            ),
            SizedBox(height: size * 0.1),
            Text(
              label,
              style: TextStyle(
                fontSize: size * 0.18,
                color: selected ? AppColors.darkPrimaryColor : Colors.black,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
