
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';

class TopupDetails extends StatelessWidget{
  
  const TopupDetails({super.key});
    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text("Topup Details", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("RM ${double.parse(vTopupDetails['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600),)),
                            ],
                          ),
                        ),          
                        Padding(
                          padding:  EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 50)),
                          child:  const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Status", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: <Widget>[
                                  if(vTopupDetails['StatusID'].toString() == "0") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                  if(vTopupDetails['StatusID'].toString() == "1") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.green, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                  if(vTopupDetails['StatusID'].toString() == "2") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Purchase Cost", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: <Widget>[                            
                                  Text("RM ${double.parse(vTopupDetails['PurchaseCost'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle:  TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Profit", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: <Widget>[                            
                                  Text("RM ${double.parse(vTopupDetails['Profit'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
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
                                  Text("${vTopupDetails["TrxType"].toString().toUpperCase()} - ${vTopupDetails['Description'].toString().toUpperCase()} ", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Date/Time", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: <Widget>[
                                  Text(vTopupDetails["Date"].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle:  TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Remark", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: <Widget>[
                                  Text(vTopupDetails["RefNo"].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text("Ref.ID", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                          trailing: 
                            Text((vTopupDetails["RefNo2"].toString().toUpperCase()=="NULL")?"":vTopupDetails["RefNo2"].toString().toUpperCase() , style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                        ),
                        const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                      ],
                    ),
                  ),
                ],
              ),
      
          )
        ]
        )
    );
  }
}
