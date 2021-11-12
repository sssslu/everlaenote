import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'public.dart' as p;
class ColorSelectPage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(10)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(11)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(12)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(13)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(14)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(15)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(16)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(17)),),
          Container(padding: EdgeInsets.all(10), width: MediaQuery
              .of(context)
              .size
              .width * 0.3, height: MediaQuery
              .of(context)
              .size
              .width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: p.colorMatcher(18)),),


        ],
      ),
    );
  }
}