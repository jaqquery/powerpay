import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/date.dart';
import 'package:powerpay/util/screenactivity.dart';
import 'package:powerpay/widgets/header.dart';
import '../../widgets/balancedisplay.dart';
import 'package:powerpay/screens/transhistory/transhistory_list.dart';

// ignore: must_be_immutable
class Transaction extends StatefulWidget {
  String dropdownValue;
  
  bool inactive; 
  bool hidden; 
  bool paused;
  bool detached;
  
  Transaction({
    super.key,
    this.dropdownValue = 'Last 90 Days',
    this.inactive = false,
    this.hidden = false,
    this.paused = false,
    this.detached = false,
  });

  @override
  State<Transaction> createState() => _Transaction();
}

class _Transaction extends ResumableState<Transaction> {
  
  List dates = [];

  late final Future _trx = getTransactionHistory();

  Future<void> getTransactionHistory() async{
    
    // hud.show();

    if(widget.dropdownValue == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
    if(widget.dropdownValue == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
    if(widget.dropdownValue == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
    if(widget.dropdownValue == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
    if(widget.dropdownValue == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);

    await Future.wait([
      server.sendRefreshToken(context)
    ]).then((List<bool> value) async {
      await server.getTransactionHistory(dates.first.toString(), dates.last.toString());
    });
    // hud.hide();
  }

  @override
  void initState(){
    super.initState();
      WidgetsBinding.instance.addObserver(this);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Function to be called after the build is completed
        getTransactionHistory();
      });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    checkState(context, state, widget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          hud.show();

          setState(() {
            getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
          });
          if(widget.dropdownValue == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
          if(widget.dropdownValue == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
          if(widget.dropdownValue == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
          if(widget.dropdownValue == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
          if(widget.dropdownValue == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);
          
          await Future.wait([
            server.sendRefreshToken(context)
          ]).then((List<bool> value) async{
            await server.getSetting(context);
            await server.getTransactionHistory(dates.first.toString(), dates.last.toString());
          });

          hud.hide();
        },
        child: PopScope(
          canPop: false,
          onPopInvoked : (didPop) async {          
            SystemNavigator.pop();     
          },
          child: 
              CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: <Widget>[
                          const SizedBox(height: 240, child: Header()),
                          BalanceDisp(visible: true)
                        ],
                      )                     
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                Text(
                                  '  Transaction History  ',
                                  style: GoogleFonts.figtree(textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: adjustResolution(context, Resolution.normal.index, 19),
                                    color: Colors.black,
                                  )
                                  ),                              
                                ),
                                Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                    
                              ]
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                              DropdownButton<String>(
                                  value: widget.dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600)),
                                  onChanged: (String? value) async{
                            
                                    if(value == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
                                    if(value == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
                                    if(value == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
                                    if(value == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
                                    if(value == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);
                                    
                                    hud.show();

                                    await Future.wait([
                                      server.sendRefreshToken(context)
                                    ]).then((List<bool> value) async{
                                      await server.getTransactionHistory(dates.first, dates.last);
                                    });
                                    hud.hide();
                                    // This is called when the user selects an item.
                                    setState(() {                          
                                      widget.dropdownValue = value!;
                                    });
                                  },
                                  items: filterDays.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )                 
                            ],)
                          ],
                        ),
                      ),
                    ),
        
                    FutureBuilder(
                      future: _trx, 
                      builder: (context, projectSnap) {
                          if (projectSnap.connectionState == ConnectionState.none &&
                                // ignore: unnecessary_null_comparison
                                projectSnap.hasData == null) {
                            //print('project snapshot data is: ${projectSnap.data}');
                            return Container();
                          }
        
                          return SliverList.builder(
                                    itemCount: lstTrxHistory.r.length,
                                    itemBuilder: (context, index){
                                      final item = lstTrxHistory.r[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                                  visualDensity: Platform.isAndroid? 
                                                          const VisualDensity(horizontal: 0, vertical: -2)
                                                            : const VisualDensity(horizontal: 0, vertical: 0),
                                                  
                                                  onTap: () async {
                                                    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  TranshistoryList(index: index)));
                                                  },
                                                  title:    Text(item['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 10), fontWeight: FontWeight.bold, color: Colors.grey))),
                                                  subtitle:
                                                    Column(children: [
                                                      Row(
                                                        children: [
                                                          item['Description'].toString() != "null" ?
                                                            Text("${item['Description'].toString().toUpperCase()} ${item['TrxType'].toString().toUpperCase()}: ${item['RefNo'].toString()}", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 13))))
                                                            : Text("${item['TrxType'].toString().toUpperCase()}: ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 13)))),
                                                        ],
                                                      ),
                                                      Row(children: [
                                                        item['Description'].toString() != "null" ?
                                                          Text("Amount: RM${double.parse(item['CreditAmount'].toString()).toStringAsFixed(2)} REF.ID: ${ item['RefNo2'].toString() == "null" ? "" : item['RefNo2'].toString() }", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 10))))
                                                          : Text("${item['CreditAmount'].toString() == "0"? "" : "Amount: RM${double.parse(item['CreditAmount'].toString()).toStringAsFixed(2)}"}REF.ID: ${ item['RefNo2'].toString() == "null" ? "" : item['RefNo2'].toString() }", style: GoogleFonts.figtree(color: Colors.grey, textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 10)))),
                                                      ],)
                                                    ],),
    
                                                  isThreeLine: true,
                                                  trailing: SizedBox(
                                                    width: 100,
                                                    child: 
                                                      Column(
                                                        children: [
                                                          const SizedBox(height:10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text(item['Amount'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: (item['Amount'][0] == '-')?Colors.red:Colors.blue, fontSize:  adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold))),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text("RM${double.parse(item['AccountBalance'].toString()).toStringAsFixed(2) }", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.w600))),
                                                            ],
                                                          ),                                                                                      
                                                        ],
                                                      ),
                                                  )
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                                  child: Divider(height: 0, color: Colors.grey.shade300),
                                                ),
                                        ],
                                      );
                                    }
                                  );
                      }
                    ),                  
                  ],
                ),
        ),
      ),
    );
  }
}
