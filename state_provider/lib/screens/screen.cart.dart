import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 카트'),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                '총액 : ${cart.getTotalPrice()}',
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Builder(
            builder: (context) {
              return ListTile(
                title: Text(items[index].title),
                subtitle: Text(items[index].price.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cart.deleteItem(items[index].id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
