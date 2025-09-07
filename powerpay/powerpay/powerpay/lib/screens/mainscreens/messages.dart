import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/screenactivity.dart';

// ignore: must_be_immutable
class Messages extends StatefulWidget {
  bool inactive; 
  bool hidden; 
  bool paused;
  bool detached;
  
  Messages({
    super.key,
    this.inactive = false,
    this.hidden = false,
    this.paused = false,
    this.detached = false,
  }); 
  
  @override
  State<Messages> createState() => _Messages();
}
  
class _Messages extends ResumableState<Messages> {
  
  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    super.initState();
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

  Future<void> _getMessage() async {
    
    await Future.wait([
      server.sendRefreshToken(context)
    ]).then((List<bool> value) async {
      await server.getNotifications();    
    });    

  }
  
  Future<void> handleClick(int item) async {

    switch (item) {
      case 0:
        if(lstMessages.r.isNotEmpty) {
          var lstMsgBkp = lstMessages;
          for(int i = 0; i< lstMsgBkp.r.length; i++){
            _deleteNofitication(lstMessages.r[i]['NotificationMessageID'].toString(),i);
          }
          setState((){
            lstMessages;
          });
        }
        
        break;      
    }
  }

  Future<bool> _deleteNofitication(final String msgId, final int index) async {
    bool stat = false;

    await Future.wait([
      server.sendRefreshToken(context)
    ]).then((List<bool> value) async {
      stat = await server.deleteNotifications(msgId);    
      if(stat == true){
        setState(() {
          lstMessages.r.removeAt(index);  
        });
      }
    });
    return stat;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text("Notifications", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Clear All')),
          ],
        ),
    ],
        
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked : (didPop) async {          
          SystemNavigator.pop();          
        },
        child: RefreshIndicator(
          color: Colors.blue,
          backgroundColor: Colors.white,
          onRefresh:  () async{
            
            setState(() async {
              hud.show();
              await Future.wait([
                server.sendRefreshToken(context)
              ]).then((List<bool> value) async {
                await server.getNotifications();    
                hud.hide();
              });    
            });
            
          },
          child: FutureBuilder(
            future: _getMessage(),
            builder: (context, projectSnap) {
             if (projectSnap.connectionState == ConnectionState.none &&
              // ignore: unnecessary_null_comparison
              projectSnap.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
            }
            return ListView.builder(
                    itemCount: lstMessages.r.length,
                    itemBuilder: (context, index) {
                      final item = lstMessages.r[index];
                      return Slidable(
                        // key: const ValueKey(1),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              onPressed: (context) {
                                hud.show();
                                _deleteNofitication(item['NotificationMessageID'].toString(), index); 
                                hud.hide(); 
                              },
                            ),
                          ]
                        ), 
                        child: 
                            Column(
                              children: [
                                ListTile(
                                  title: Text(item['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 10), color: Colors.grey, fontWeight: FontWeight.bold))),
                                  subtitle: Text(item['NotificationMessage'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 14)))),
                                ),
                                Divider(height: 0, color: Colors.grey.shade300),
                              ],
                            ),                          
                            
                        );
                    }
                  );
            }
          ),
        ),
      ),
    );
  }
}




