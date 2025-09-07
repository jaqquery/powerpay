import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';

// ignore: must_be_immutable
class Livechat extends StatelessWidget {

  const Livechat({super.key});

  @override
  Widget build(BuildContext context) {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: themeColor, // Status bar color
      ));

    return Scaffold(    
      appBar: AppBar( 
          title: Text('PowerPay Live Chat', style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.white, fontSize: adjustResolution(context, Resolution.normal.index, 20)))), 
          backgroundColor: const Color(0xFF1F6FC8),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: white, size: adjustResolution(context, Resolution.container.index, 20)),
            onTap: () {
              Navigator.pop(context);
            } ,
          )
        ),      
    
        body:Tawk(
              directChatLink: 'https://tawk.to/chat/65ee71c48d261e1b5f6b5af6/1holmoq08',
              visitor: TawkVisitor(
                  name: username,
                  email: '',                
              ),            
        )
    );
  }
}
