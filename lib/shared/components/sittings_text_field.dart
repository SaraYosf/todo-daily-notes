import 'package:flutter/material.dart';
class SittingTextField extends StatelessWidget {
   SittingTextField({required this.txt,required this.head, required this.bottomSheet,super.key});
   Function bottomSheet;
String txt;
String head;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          Text(head),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(txt),
                InkWell(
                    onTap: (){
                      bottomSheet;
                    },
                    child: Icon(Icons.arrow_drop_down,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}