import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/widgets/bottomnavigationbar.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';

class BankPage extends StatefulWidget {
  final String uri;

  const BankPage({super.key, required this.uri});

  @override
  State<BankPage> createState() => _BankPage();
}

class _BankPage extends State<BankPage> {
  // ignore: unused_field
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    //handling notification receive from broadcast
    messagingService.configureMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        if(didPop){
          return;
        }
        
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Bottom(currentIndex: 2)),
          (route) => route.isFirst,
        );
        
      }),
      child: Scaffold(
        appBar: AppBar(
        title: Text("Online Transaction", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        leading: GestureDetector(
                  child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16),),
                  onTap: () {
                    
                    Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Bottom(currentIndex: 2)),
                      (route) => route.isFirst,
                    );
                    
                  } ,
                ),  
        ),
        body: 
          WebView(
            initialUrl: widget.uri,
            javascriptMode: JavascriptMode.unrestricted, // Allow JavaScript execution (optional)
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
            },
          ),
        
      ),
    );
  }
}