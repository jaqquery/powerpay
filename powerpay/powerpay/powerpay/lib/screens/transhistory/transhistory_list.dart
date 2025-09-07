import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';

// ignore: must_be_immutable
class TranshistoryList extends StatefulWidget {
  
  int index;
  TranshistoryList({super.key, required this.index});

  @override
  State<TranshistoryList> createState() => _TranshistoryList();
}

class _TranshistoryList extends State<TranshistoryList> {

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(
        backgroundColor: white,
        title: Text("Transaction Details", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: white,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(lstTrxHistory.r[widget.index]['Amount'][0] == '-') ...[
                        Text(lstTrxHistory.r[widget.index]['Amount'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600))),
                      ]else...[
                        Text(lstTrxHistory.r[widget.index]['Amount'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600))),
                      ]
                    ],
                  ),
                ),
          
                const Padding(
                  padding:  EdgeInsets.only(top: 50),
                  child:  Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ),
          
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text("Date/Time", style: GoogleFonts.figtree(textStyle: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500)))),
                    trailing: 
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                            Text(lstTrxHistory.r[widget.index]['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                    ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text("Type", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500 ))),
                  trailing: 
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          if(lstTrxHistory.r[widget.index]['Description'].toString().toLowerCase() == "null")...[
                            Text(lstTrxHistory.r[widget.index]['TrxType'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                          ]else ...[
                            Text("${lstTrxHistory.r[widget.index]['Description'].toString().toUpperCase()} ${lstTrxHistory.r[widget.index]['TrxType'].toString().toUpperCase()}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),  
                          ]
                        ],
                      ),
                    ),
                ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text("Ref.ID", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                    trailing: 
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                          if(lstTrxHistory.r[widget.index]['RefNo2'].toString() == 'null') ...[
                              const Text(" "),
                            ]else...[
                              Text(lstTrxHistory.r[widget.index]['RefNo2'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                            ]
                          ],
                        ),
                      ),
                    ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
            ],
          ),
        )
      )
    );
  }
}
