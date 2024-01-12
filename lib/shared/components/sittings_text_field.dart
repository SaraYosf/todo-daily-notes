import 'package:flutter/material.dart';


class SittingTextField extends StatefulWidget {
   SittingTextField({required this.txt,required this.head,super.key});
String txt;
String head;

  @override
  State<SittingTextField> createState() => _SittingTextFieldState();
}

class _SittingTextFieldState extends State<SittingTextField> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),

      child: Column(
        children: [
          Text(widget.head),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.txt),
                InkWell(
                    onTap: (){},
                    child: Icon(Icons.arrow_drop_down,))

              ],
            ),
          ),
        ],
      ),
    );
  }
}
