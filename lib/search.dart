import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      color: Color(0xFFFFE57E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
        height: 35,
        width: 340,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search, color: Colors.black26,),
            SizedBox(height: 10,),
            Text('Search', style: TextStyle(color: Colors.black26),)

          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,

        ),
      ),
        ],
      ),
    );
  }
}
