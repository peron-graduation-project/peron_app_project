
import 'package:flutter/material.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
        appBar: AppBar(
          title:
          Text("المفضلة",
              style: theme.headlineMedium!.copyWith(fontSize: 20)),
      centerTitle: true,),
        body: Column(
            children: [
              SizedBox(
                height: screenWidth * 0.02,
              ),
              const Divider(
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),
            ])

    );
  }
}