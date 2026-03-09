import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/routes/app_pages.dart';
import '../../../services/cart_service.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  void _processCheckout() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isProcessing = false);
        final cart = Get.find<CartService>();
        cart.clear(); // Clear cart on success
        
        Get.defaultDialog(
          title: 'Order Placed!',
          content: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          middleText: 'Your order has been successfully placed.',
          textConfirm: 'View Orders',
          textCancel: 'Home',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // close dialog
            Get.offAllNamed(Routes.ORDERS);
          },
          onCancel: () {
            Get.offAllNamed(Routes.HOME);
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipping Information', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              Text('Payment Information', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.length < 16 ? 'Invalid format' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Place Order',
                  isLoading: _isProcessing,
                  onPressed: _processCheckout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
