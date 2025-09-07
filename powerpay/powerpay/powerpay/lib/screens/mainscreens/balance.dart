import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/balancelist/balance_history_list.dart';
import 'package:powerpay/screens/fpx/fpx.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/date.dart';
import 'package:powerpay/util/screenactivity.dart';
import 'package:powerpay/widgets/header.dart';
import 'package:powerpay/widgets/balancedisplay.dart';

// ignore: must_be_immutable
class Balance extends StatefulWidget {
  String dropdownValue;
  bool inactive; 
  bool hidden; 
  bool paused;
  bool detached;

  Balance({
    super.key,
    this.dropdownValue = 'Last 90 Days',
    this.inactive = false,
    this.hidden   = false,
    this.paused   = false,
    this.detached = false,
});

  @override
  State<Balance> createState() => _Balance();
}

class _Balance extends ResumableState<Balance> {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    checkState(context, state, widget);
  }

  List<String> dates = [];

  Future<void> getBalanceReport() async{    
    
    if(widget.dropdownValue == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
    if(widget.dropdownValue == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
    if(widget.dropdownValue == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
    if(widget.dropdownValue == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
    if(widget.dropdownValue == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);
    
    try{
      await Future.wait([
        server.sendRefreshToken(context)
      ]).then((List<bool> value) async{
        await server.getBalanceReport(dates.first, dates.last);
        await server.getBalance();
        // ignore: use_build_context_synchronously
        await server.getSetting(context);

        setState(() {
          getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
        });
      });

    }catch (e){
      if (kDebugMode) {
        print(e);
      }
    }  
  }

  late Future<void> _getBalanceReport;

  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    _getBalanceReport = getBalanceReport();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
        // Function to be called after the build is completed
        getBalanceReport();
      });
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
          if(widget.dropdownValue == filterDays[0]) dates = getDateRange(EnumDateRange.ninetyDays.days);
          if(widget.dropdownValue == filterDays[1]) dates = getDateRange(EnumDateRange.thirtyDays.days);
          if(widget.dropdownValue == filterDays[2]) dates = getDateRange(EnumDateRange.sevenDays.days);
          if(widget.dropdownValue == filterDays[3]) dates = getDateRange(EnumDateRange.yesterday.days);
          if(widget.dropdownValue == filterDays[4]) dates = getDateRange(EnumDateRange.today.days);  
          await Future.wait([
            server.sendRefreshToken(context)
          ]).then((List<bool> value) async{
            // await server.getSetting(context);
            await server.getBalanceReport(dates.first, dates.last);
            await server.getBalance();
          });
    
          setState(() {
            getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
          });
          hud.hide();
        },
        child: PopScope(
          canPop: false,
          onPopInvoked : (didPop) async {          
            SystemNavigator.pop();      
          },
          child: Builder(
            builder: (context) {
              return Container(
                  color: Colors.white,
                  child: 
                        CustomScrollView(
                          slivers: [
                              SliverToBoxAdapter(
                              child: Stack(children: [
                                const SizedBox(height: 240, child: Header()),
                                BalanceDisp(visible: true), 
                              ]) 
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400)),
                                    Text(
                                      '  DuitNow Payment  ',
                                      style: GoogleFonts.figtree(textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: adjustResolution(context, Resolution.normal.index, 19),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400)),
                                  ]
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 12,),
                            ),
                            SliverToBoxAdapter(
                              child:
                                Padding(
                                  padding: const EdgeInsets.only(left: 18, right: 18),
                                  child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5.0),
                                          child: Container(
                                                  height: adjustResolution(context, Resolution.normal.index, 240),
                                                  // height: 240.0,
                                                  width: double.infinity,
                                                  margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.black, width: 0.5), 
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: adjustResolution(context, Resolution.normal.index, 120),
                                                                width: adjustResolution(context, Resolution.normal.index, 120),
                                                                decoration: 
                                                                  const BoxDecoration(                                                       
                                                                    image: DecorationImage(
                                                                      image: AssetImage("assets/duitnow-logo.jpg"),
                                                                      fit: BoxFit.fill
                                                                    )
                                                                  ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 10),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Text("POWER PAY SDN BHD", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 14)))),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 4.0),
                                                                      child: Text("Business Registration No:  ", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black54, fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                                    ),
                                                                    
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 84),
                                                                      child: Text(businessRegNum, style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize:  adjustResolution(context, Resolution.normal.index, 14)))),
                                                                    ),
                                                                    
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 4.0),
                                                                      child: Text("Recipient's Reference:       ",style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black54, fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 60),
                                                                      child: Text(recpRef, style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 14)))),
                                                                    ),                                                          
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 4.0),
                                                                      child: Text("Other Payment Details:     ", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black54, fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 60),
                                                                      child: Wrap(children: [Text(otherPayDet, style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 14))))]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 14)),
                                                        child: Wrap(children: [Center(child: Text("Transfer via DuitNow! Autocredit.\n Mon-Sun 7:00am-11.45pm. (No fees per transaction)", style:  GoogleFonts.figtree(textStyle:  TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 12), color: Colors.black54, )), textAlign: TextAlign.center))] ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                    ],
                                                  )
                                                ),
                                  ),
                                )
                            ),
                            const SliverToBoxAdapter(child: SizedBox(height:20)),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                    Text(
                                      '  Online Payment  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: adjustResolution(context, Resolution.normal.index, 19),
                                        color: Colors.black,
                                      ),                              
                                    ),
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                  ]
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(child: SizedBox(height:10)),
                            SliverToBoxAdapter(
                              child: 
                              Padding(
                                padding: const EdgeInsets.only(left: 18, right: 18),
                                child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: Container(
                                                    height: adjustResolution(context, Resolution.container.index, 130),
                                                    width: double.infinity,
                                                    margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.black, width: 0.5), 
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 20, top: 10.0),
                                                                  child: Container(
                                                                    height: adjustResolution(context, Resolution.container.index, 60),
                                                                    width: adjustResolution(context, Resolution.container.index, 125),
                                                                    decoration: 
                                                                      const BoxDecoration(                                                       
                                                                        image: DecorationImage(
                                                                          image: AssetImage("assets/fpx-gateway-icon.png"),
                                                                          fit: BoxFit.fill
                                                                        )
                                                                      ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 10, right: 10),
                                                                  child: Column(
                                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      ElevatedButton.icon(
                                                                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), backgroundColor: buttonColor, foregroundColor: Colors.white), 
                                                                        label:  Text("Online Payment", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                                                                        icon: Icon(Icons.payments_outlined, size: adjustResolution(context, Resolution.normal.index, 16)),
                                                                        onPressed: () {
                                                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const OnlinePayment()));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 14)),
                                                          child: Wrap(children:  [Center(child: Text("Online Payment through FPX (RM1 for each transaction)", style:  GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 12), color: Colors.black54, )), textAlign: TextAlign.center,))]),
                                                        )
                                                      ],
                                                    )
                                                  ),
                                    ),
                              ),
                            ),
                            const SliverToBoxAdapter(child: SizedBox(height:10)),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400)),
                                    Text(
                                      '  Balance History  ',
                                      style: GoogleFonts.figtree(textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: adjustResolution(context, Resolution.normal.index, 19),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Divider(height: 0, color: Colors.grey.shade400)),
                                  ]
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: 
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                                child: Row(
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
                                                await server.getBalanceReport(dates.first, dates.last);
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
                                          ),
                                  ],
                                ),
                              )
                            ),
              
                            FutureBuilder(
                              future  : _getBalanceReport, 
                              builder : (context, projectSnap) {
                                if (projectSnap.connectionState == ConnectionState.none &&
                                    // ignore: unnecessary_null_comparison
                                    projectSnap.hasData == null) {
                                      //print('project snapshot data is: ${projectSnap.data}');
                                      return Container();
                                    }
        
                                    return SliverList.builder(
                                              itemCount: lstBalReport.r.length,
                                              itemBuilder: (context, index){
                                                final item = lstBalReport.r[index];
                                                return Column(
                                                  children: [
                                                              ListTile(                            
                                                                title: Text(item['Date'].toString(),style: GoogleFonts.figtree(textStyle:  TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 10)), fontWeight: FontWeight.bold, color: Colors.grey)),
                                                                subtitle: 
                                                                  Column(children: [
                                                                    Row(children: [ Text(item['TrxType'].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 13)))) ]),
                                                                    Row(children: [
                                                                      lstBalReport.r[index]['RefNo2'].toString() == "null" ?
                                                                          Text('REF.ID: ', style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 10))))
                                                                          : Text('nREF.ID: ${item['RefNo2'].toString()}', style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 10)))),
    
                                                                    ],)
                                                                  ],),
                                                                tileColor: Colors.transparent,
                                                                trailing: SizedBox(
                                                                  width: 100,                                                                
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(height: 6),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(item['Amount'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.blue, fontSize: adjustResolution(context, Resolution.normal.index, 13), fontWeight: FontWeight.bold)), textAlign: TextAlign.end),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          if(item['Status'].toString().toLowerCase() == "success") ...[
                                                                              Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.green, fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.bold)),textAlign: TextAlign.end), 
                                                                          ]else if(item['Status'].toString().toLowerCase() == "failed") ...[
                                                                              Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.bold)),textAlign: TextAlign.end), 
                                                                          ]else if(item['Status'].toString().toLowerCase() == "pending") ...[
                                                                              Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 12), fontWeight: FontWeight.bold)),textAlign: TextAlign.end), 
                                                                          ]
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                onTap: () async {                                                                    
                                                                    await Future.wait([
                                                                      server.sendRefreshToken(context)
                                                                    ]).then((List<bool> value) async{
                                                                      await server.getBalanceDetails(item['ID'].toString());
                                                                      // ignore: use_build_context_synchronously
                                                                      Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const BalancehistoryList()));
                                                                    });
                                                                  }
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
                        )
                      );
            }
          ),
        ),
      ),
    );
  }
}
