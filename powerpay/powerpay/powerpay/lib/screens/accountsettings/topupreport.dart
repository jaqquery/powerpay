import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/screens/receipt/topup_details.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/date.dart';

class TopupReport extends StatefulWidget{
    const TopupReport({super.key});
    @override
    State<TopupReport> createState() => _TopupReport();
}

class _TopupReport extends State<TopupReport> {
  String dropdownValue = filterDays.first;
  List<String> dates = [];

  Future<void> getTopupReport() async{
    if(lstTopupReport.r.isEmpty){

      if(dropdownValue == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
      if(dropdownValue == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
      if(dropdownValue == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
      if(dropdownValue == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
      if(dropdownValue == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);
      
      await Future.wait([
        server.sendRefreshToken(context)
      ]).then((List<bool> value) async {
        await server.getTopupReport(dates.first, dates.last);
      });    
    }
  }

  @override
  Widget build(BuildContext context){

      return Scaffold(
        appBar: AppBar(
        backgroundColor: white,
        title: Text("Topup Report", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
            onTap: () {
              lstTopupReport.r.clear();
              Navigator.pop(context);
            } ,
          )
        ),
        body: Builder(
            builder: (context) {
              return Container(
                color: white,
                child: CustomScrollView(
                  slivers: [        
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600)),
                              onChanged: (String? value) async {
                                
                                if(value == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
                                if(value == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
                                if(value == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
                                if(value == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
                                if(value == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);
          
                                hud.show();
                                await Future.wait([
                                  server.sendRefreshToken(context)
                                ]).then((List<bool> value) async {
                                  await server.getTopupReport(dates.first, dates.last);
                                });
                                hud.hide();
                                
                                // This is called when the user selects an item.
                                setState(() {                          
                                  dropdownValue = value!;
                                });
                              },
                              items: filterDays.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                
                    FutureBuilder(
                      future: getTopupReport(), 
                      builder: (context, projectSnap){
                                if (projectSnap.connectionState == ConnectionState.none &&
                                    // ignore: unnecessary_null_comparison
                                    projectSnap.hasData == null) {
                                    //print('project snapshot data is: ${projectSnap.data}');
                                    return Container();
                                }
          
                                return SliverList.builder(
                                  itemCount: lstTopupReport.r.length,
                                  itemBuilder: (context, index){
                                    final item = lstTopupReport.r[index];
                                    return Column(children: [
                                      Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: ListTile(
                                            visualDensity: Platform.isAndroid? 
                                                          const VisualDensity(horizontal: 0, vertical: -4)
                                                            : const VisualDensity(horizontal: 0, vertical: 0),
                                            onTap: () async {
                                              await Future.wait([
                                                server.sendRefreshToken(context)
                                              ]).then((List<bool> value) async {
                                                await server.getTopupDetail(item['ProductPurchaseID'].toString());
                                                // ignore: use_build_context_synchronously
                                                Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const TopupDetails()));
                                              });
                                            },
                                            title:    Text(item['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 10), fontWeight: FontWeight.bold))),
                                            subtitle:
                                              Column(children: [
                                                Row(children: [
                                                  item['Description'].toString() == "null" ?
                                                    Text(item['TrxType'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold)))
                                                      :Text("${item['Description'].toString().toUpperCase()} ${item['TrxType'].toString().toUpperCase()}", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold))),
                                                ],),
                                                Row(children: [
                                                    Text("REFID: ${(item['RefNo2'].toString() == "null")?"":item['RefNo2'].toString().toUpperCase()}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 10), fontWeight: FontWeight.bold))),
                                                ],)
                                              ],),
                                            
                                            trailing: SizedBox(
                                              width: 150,
                                              child: 
                                                Column(
                                                  children: [
                                                    const SizedBox(height:2),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        if(item['StatusID'].toString() == "0") Text("RM${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: black, fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold))),
                                                        if(item['StatusID'].toString() == "1") Text("RM${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor, fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold))),
                                                        if(item['StatusID'].toString() == "2") Text("RM${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold))),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        if(item['StatusID'].toString() == "0") Text(item['Status'].toString().trim(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey , fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.w500))),
                                                        if(item['StatusID'].toString() == "1") Text(item['Status'].toString().trim(), style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor , fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.w500))),
                                                        if(item['StatusID'].toString() == "2") Text(item['Status'].toString().trim(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red , fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.w500))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                            )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 24,  right: 30),
                                          child: Divider(thickness: 1, color: Colors.grey.shade300,),
                                        ),
                                    ]);
                                  }
                                );
                      }
                    ),
                  ],
                ),
              );
            }
          ),
        
      );
  }
}