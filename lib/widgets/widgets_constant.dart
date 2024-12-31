import 'package:flutter/material.dart';

class WidgetConstant {
  static Widget infoUser() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.orangeAccent[50],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/img_avatar.png',
              fit: BoxFit.cover, height: 70, width: 70),
          Text('ADMIN',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Warehouse: ',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            TextSpan(
                text: 'HY1',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600))
          ]))
        ],
      ),
    );
  }
}
