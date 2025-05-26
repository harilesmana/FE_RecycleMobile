import 'package:flutter/material.dart';
import '../util/colors.dart';
import 'scanBarcodeScreen.dart';
import 'finalScreen.dart';

class AcceptedItemsPage extends StatefulWidget {
  @override
  _AcceptedItemsPageState createState() => _AcceptedItemsPageState();
}

class _AcceptedItemsPageState extends State<AcceptedItemsPage> {
  String searchQuery = '';
  String selectedCategory = 'all';

  final List<Map<String, String>> allItems = [
    {'name': 'Botol plastik bening ukuran kecil', 'price': 'Rp80/Botol', 'category': 'bening'},
    {'name': 'Botol plastik bening ukuran sedang', 'price': 'Rpxx/Pcs', 'category': 'bening'},
    {'name': 'Botol plastik bening ukuran besar', 'price': 'Rpxx/Pcs', 'category': 'bening'},
    {'name': 'Botol plastik warna ukuran kecil', 'price': 'Rp24/Botol', 'category': 'warna'},
    {'name': 'Botol plastik warna ukuran sedang', 'price': 'Rpxx/Pcs', 'category': 'warna'},
    {'name': 'Kaleng aluminium kecil', 'price': 'Rp150/Pcs', 'category': 'kaleng'},
    {'name': 'Kaleng aluminium besar', 'price': 'Rp300/Pcs', 'category': 'kaleng'},
    {'name': 'Kertas koran', 'price': 'Rp5/Lembar', 'category': 'kertas'},
    {'name': 'Kardus bekas', 'price': 'Rp20/Kg', 'category': 'kardus'},
  ];

  final List<Map<String, dynamic>> categories = [
    {'label': 'all', 'icon': Icons.dashboard},
    {'label': 'bening', 'icon': Icons.water_drop},
    {'label': 'warna', 'icon': Icons.color_lens},
    {'label': 'kaleng', 'icon': Icons.circle},
    {'label': 'kertas', 'icon': Icons.description},
    {'label': 'kardus', 'icon': Icons.cardboard},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 600;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final filteredItems = allItems.where((item) {
      final matchSearch = item['name']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchCategory = selectedCategory == 'all' || item['category'] == selectedCategory;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ScanBarcodeScreen()),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FinalScreen()),
            ),
          ),
        ],
        backgroundColor: AppColors.green,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Accepted Items',
                        style: TextStyle(
                          fontSize: isTablet ? 26 : 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        onChanged: (value) => setState(() => searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search items',
                          prefixIcon: Icon(Icons.search, size: isTablet ? 28 : 22),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018,
                            horizontal: screenWidth * 0.04,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        height: isTablet ? 70 : 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            final isSelected = selectedCategory == cat['label'];
                            return GestureDetector(
                              onTap: () => setState(() => selectedCategory = cat['label']),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.darkPrimaryColor : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.darkPrimaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      cat['icon'],
                                      color: isSelected ? Colors.white : AppColors.darkPrimaryColor,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      cat['label'],
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AppColors.darkPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Bagian List/Grid Items
                      if (filteredItems.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.3),
                            child: Text("Tidak ada item ditemukan"),
                          ),
                        )
                      else
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: screenHeight * 0.6, // Batas maksimal tinggi scroll
                          ),
                          child: isTablet
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: filteredItems.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isPortrait ? 2 : 3,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: isPortrait ? 3.5 : 4,
                                  ),
                                  itemBuilder: (context, index) {
                                    final item = filteredItems[index];
                                    return ItemCard(item: item, isTablet: isTablet);
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: filteredItems.length,
                                  itemBuilder: (context, index) {
                                    final item = filteredItems[index];
                                    return ItemCard(item: item, isTablet: isTablet);
                                  },
                                ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Map<String, String> item;
  final bool isTablet;

  const ItemCard({required this.item, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          _getCategoryIcon(item['category']),
          size: isTablet ? 40 : 30,
          color: AppColors.darkPrimaryColor,
        ),
        title: Text(
          item['name']!,
          style: TextStyle(fontSize: isTablet ? 18 : 14),
        ),
        subtitle: Text(
          item['price']!,
          style: TextStyle(fontSize: isTablet ? 16 : 12),
        ),
        trailing: Icon(
          Icons.add,
          size: isTablet ? 28 : 22,
          color: AppColors.darkPrimaryColor,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Anda memilih: ${item['name']}')),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String? category) {
    switch (category) {
      case 'bening':
        return Icons.water_drop;
      case 'warna':
        return Icons.color_lens;
      case 'kaleng':
        return Icons.circle;
      case 'kertas':
        return Icons.description;
      case 'kardus':
        return Icons.cardboard;
      default:
        return Icons.category;
    }
  }
}
