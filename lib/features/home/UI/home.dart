import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/UI/cart.dart';
import 'package:myapp/features/home/UI/product_tile.dart';
import 'package:myapp/features/home/bloc/home_bloc.dart';
import 'package:myapp/features/wishlist/UI/wishlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent()); //runs at the first
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen:
          (previous, current) =>
              current is HomeActionState, //here the actions are handled
      buildWhen:
          (previous, current) =>
              current is! HomeActionState, //here the UI is built
      listener: (context, state) {
        if (state is HomeCartNavigate) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cartpage()),
          );
        } else if (state is HomeWishlistNavigate) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistPage()),
          );
        } else if (state is ProductAddedToCart) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Product added to cart')));
        } else if (state is ProductAddedToWishlist) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Product added to wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoading:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case HomeLoadedSuccess:
            final successstate = state as HomeLoadedSuccess;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber.shade200,
                title: Text('Our Grocery App'),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successstate.products.length,
                itemBuilder: (context, index) {
                  return ProductTilePage(
                    homeProductData: successstate.products[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeError:
            return Scaffold(body: Text('Error Occured'));
          default:
            return SizedBox();
        }
      },
    );
  }
}
