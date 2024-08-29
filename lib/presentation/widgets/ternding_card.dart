import 'package:flutter/material.dart';

Widget trendingCard(String? imageUrl,String title) {
  return Container(
    margin: const EdgeInsets.all(8),
    // height: 300,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(5),
        boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 3,spreadRadius: 3,offset: Offset(1, 2))]
        ),
    child: Column(
      children: [
        const ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
          child: Image(
            image: AssetImage(
                'assets/images/NEWZZ.png'),
            fit: BoxFit.cover,
            height: 200,
            width: double.maxFinite,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(title,style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'times'
          ),),
        )
      ],
    ),
  );
}
