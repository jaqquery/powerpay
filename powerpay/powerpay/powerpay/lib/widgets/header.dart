import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  final int index;
  const Header({
    super.key,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 220,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[                      
                  Color(0xFF3EB9EC),
                  Color(0xFF1F6FC8),
                ],
              ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),              
        ),
      ],
    );
  }  
}