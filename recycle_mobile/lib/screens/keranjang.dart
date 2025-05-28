import 'package:flutter/material.dart';
import '../util/colors.dart';
import 'thank.dart';

class KeranjangScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const KeranjangScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index]['quantity'] > 1) {
        widget.cartItems[index]['quantity'] -= 1;
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  void _increaseQuantity(int index) {
    setState(() {
      widget.cartItems[index]['quantity'] += 1;
    });
  }

  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item dihapus dari keranjang'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  void _clearCart() {
    setState(() {
      widget.cartItems.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua item dihapus dari keranjang'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in widget.cartItems) {

      final priceString = item['price'].replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceString) ?? 0;
      total += price * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.15;
    final iconButtonPadding = 4.0;

    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        leadingWidth: 70,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Back",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        title: const Text('Keranjang', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            tooltip: 'Hapus semua item',
            onPressed: _clearCart,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
              child: Text(
                'Keranjang kosong',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.asset(
                          item['image'],
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(item['price']),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(iconButtonPadding),
                              icon: const Icon(Icons.remove),
                              tooltip: 'Kurangi jumlah',
                              onPressed: () => _decreaseQuantity(index),
                            ),
                            Text(
                              item['quantity'].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(iconButtonPadding),
                              icon: const Icon(Icons.add),
                              tooltip: 'Tambah jumlah',
                              onPressed: () => _increaseQuantity(index),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(iconButtonPadding),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Hapus item',
                              onPressed: () => _removeItem(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.lightPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp${_calculateTotal().toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThankYouScreen()),
                        );
                      },
                      child: const Text(
                        'Withdraw',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
