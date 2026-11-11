import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import 'qr_pickup_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: CartModel.instance,
        builder: (context, child) {
          final items = CartModel.instance.items;

          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang belanja Anda masih kosong.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 56,
                        height: 56,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ProductImage(path: item.product.image),
                        ),
                      ),
                      title: Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${item.qty}x Rp ${item.product.price}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          CartModel.instance.remove(item);
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp ${CartModel.instance.total}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Lanjut ke Pembayaran (QR)',
                        icon: Icons.qr_code,
                        onPressed: () {
                          if (CartModel.instance.items.isNotEmpty) {
                            final total = CartModel.instance.total;
                            CartModel.instance.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QrPickupScreen(
                                  orderCode: 'SB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                                  shop: 'Toko Hemat Berkah',
                                  pickupTime: '17:00 - 19:00 WIB',
                                  total: total,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}