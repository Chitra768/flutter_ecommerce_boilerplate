import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_pages.dart';
import '../../../widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a real app we would fetch order history via OrderController.
    // For boilerplate, demonstrating a mock list of past orders.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // Dummy count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.shopping_bag, color: Colors.white),
              ),
              title: Text('Order #100${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Text('Placed on 10 Oct 2026'),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${index == 0 ? 'Processing' : 'Delivered'}',
                    style: TextStyle(
                      color: index == 0 ? Colors.orange : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: const Text('\$120.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
