import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_main/controller/cart_screen_controller.dart';
import 'package:shopping_cart_main/controller/home_screen_controller.dart';
import 'package:shopping_cart_main/controller/product_details_controller.dart';
import 'package:shopping_cart_main/model/cart_model.dart';
import 'package:shopping_cart_main/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 Hive.registerAdapter(CartModelAdapter());
 var cartbox = await Hive.openBox<CartModel>("cartBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(create: (context)=> ProductDetailsController(),),
        ChangeNotifierProvider(create: (context) => CartScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}