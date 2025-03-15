import 'package:flutter/material.dart';

class MapSearch extends StatelessWidget {
 final void Function(String)? onSubmitted;
  const MapSearch({super.key, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
    ),
    child: TextField(
      onSubmitted:onSubmitted ,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: "ابحث عن اسم المنطقة او المكان",
        hintStyle: theme.displayMedium!.copyWith(color: Color(0xff818181)),
        border: InputBorder.none,
      ),
    ),
    );
  }
}
