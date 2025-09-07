import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BalancehistoryList extends StatelessWidget {
  
  const BalancehistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
        backgroundColor: white,
        title: Text("Balance Details", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
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
                        if(vBalDetails['Amount'][0] == '-') ...[
                          Text(vBalDetails['Amount'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600))),
                        ]else...[
                          Text(vBalDetails['Amount'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600))),
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
                  leading: Text("Date/Time", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                  trailing: 
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          Text(vBalDetails['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text("Type", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                    trailing: 
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                            if(vBalDetails['Description'].toString().toLowerCase() == "null")...[
                              Text(vBalDetails['TrxType'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600)))
                            ] else ...[
                              Text("${vBalDetails['Description'].toString().toUpperCase()} ${vBalDetails['TrxType'].toString().toUpperCase()}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                            ],
                          ],
                        ),
                      ),
                  ),
                  const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text("Status", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                    trailing: 
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                            if(vBalDetails['StatusID'].toString().toLowerCase() == "0") Text(vBalDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                            if(vBalDetails['StatusID'].toString().toLowerCase() == "1") Text(vBalDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.green, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                            if(vBalDetails['StatusID'].toString().toLowerCase() == "2") Text(vBalDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),      
                          ],
                        ),
                      ),
                  ),
                  const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text("Ref.ID", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500),)),
                    trailing: 
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                          if(vBalDetails['RefNo2'].toString() == 'null') ...[
                              Text(" ", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                            ]else...[
                              Text(vBalDetails['RefNo2'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
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
