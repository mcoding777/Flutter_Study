import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/models/cart.dart';
import 'package:state_provider/repositories/item_list.dart';
import 'package:state_provider/screens/item_screen.dart';
import 'package:state_provider/screens/screen.cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        Provider(
          create: (_) => ItemList(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Provider Example',
          initialRoute: '/',
          routes: {
            '/': (context) => const ItemScreen(),
            '/cart': (context) => const CartScreen(),
          },
        );
      },
    );
  }
}
