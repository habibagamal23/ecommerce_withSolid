import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/route/approuter.dart';
import 'new_adress_cubit.dart';

class PaymentScreenaddnew extends StatelessWidget {
  const PaymentScreenaddnew({Key? key}) : super(key: key);

  Future<void> _goToMapAndUpdateAddress(BuildContext context) async {
    final newAddress = await context.push<String?>(ConstantsRoutes.Mapscreen);
    if (newAddress != null && newAddress.isNotEmpty) {
      context.read<NewAdressCubit>().updateAddress(newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.read<NewAdressCubit>().fetchAddress(),
                  icon: const Icon(Icons.refresh, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<NewAdressCubit, NewAdressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return AddressCard(
                    title: "Current Address",
                    content: "Loading...",
                    icon: Icons.my_location,
                  );
                } else if (state is AddressLoaded) {
                  return AddressCard(
                    title: "Current Address",
                    content: state.address,
                    icon: Icons.my_location,
                    onPressed: () => _goToMapAndUpdateAddress(context),
                  );
                } else if (state is AddressError) {
                  return AddressCard(
                    title: "Error",
                    content: state.error,
                    icon: Icons.error_outline,
                    onPressed: () => _goToMapAndUpdateAddress(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),
            AddressCard(
              title: "Contact Information",
              content: "+84932000000\namandamorgan@example.com",
              icon: Icons.edit,
            ),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback? onPressed;

  const AddressCard({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
