import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_main/controller/cart_screen_controller.dart';
import 'package:shopping_cart_main/controller/product_details_controller.dart';
import 'package:shopping_cart_main/view/cart_screen/cart_screen.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductDetailsController>()
            .getProductDetails(widget.productId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsScreenProvider =
        context.watch<ProductDetailsController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 40,
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: productDetailsScreenProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          alignment: Alignment.topRight,
                          height: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      productDetailsScreenProvider
                                              .productDetails?.image ??
                                          ""))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(6, 10),
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(.5))
                                ]),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.favorite_outline,
                              size: 30,
                            ),
                          ),
                        ),
                        Text(
                          "${productDetailsScreenProvider.productDetails?.title}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: productDetailsScreenProvider
                                  .productDetails?.rating?.rate ??
                              0,
                          maxRating: 5,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${productDetailsScreenProvider.productDetails?.description}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                            "${productDetailsScreenProvider.productDetails?.price}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context.read<CartScreenController>().addProduct(
                                name:
                                    "${productDetailsScreenProvider.productDetails?.title}",
                                id: productDetailsScreenProvider
                                    .productDetails!.id!,
                                price: productDetailsScreenProvider
                                        .productDetails?.price ??
                                    0,
                                desc:
                                    "${productDetailsScreenProvider.productDetails?.description}",
                                image:
                                    "${productDetailsScreenProvider.productDetails?.image}");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                  
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_mall_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}