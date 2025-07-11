import 'package:flutter/material.dart';
import 'package:myapp/features/home/bloc/home_bloc.dart';
import 'package:myapp/features/home/models/home_product_data.dart';

class ProductTilePage extends StatelessWidget {
  final HomeBloc homeBloc;
  final HomeProductData homeProductData;
  const ProductTilePage({super.key, required this.homeProductData, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(homeProductData.image),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            homeProductData.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(homeProductData.quantity.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs " + homeProductData.price.toString()),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: homeProductData));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                       homeBloc.add(HomeProductCartButtonClickedEvent(clickedProduct: homeProductData));
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
