import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/accountsettings/changename.dart';
import 'package:powerpay/screens/accountsettings/changepassword.dart';
import 'package:powerpay/screens/accountsettings/commissionrate.dart';
import 'package:powerpay/screens/accountsettings/privacypolicy.dart';
import 'package:powerpay/screens/accountsettings/registerdealer.dart';
import 'package:powerpay/screens/accountsettings/settingstoggle.dart';
import 'package:powerpay/screens/accountsettings/termsandconditions.dart';
import 'package:powerpay/screens/accountsettings/topupreport.dart';
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/screenactivity.dart';
import 'package:powerpay/widgets/balancedisplay.dart';
import 'package:powerpay/widgets/header.dart';
import 'package:powerpay/screens/accountsettings/kyc.dart';

// ignore: must_be_immutable
class Settings extends StatefulWidget {
  bool inactive; 
  bool hidden; 
  bool paused;
  bool detached;

  Settings({ 
    super.key, 
    this.inactive = false,
    this.hidden = false,
    this.paused = false,
    this.detached = false,
  });
  
  @override
  State<Settings> createState() => _Settings();
}
  
class _Settings extends ResumableState<Settings> {

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          hud.show();
          await Future.wait([
            server.sendRefreshToken(context)
          ]).then((List<bool> value) async {
            await server.getSetting(context);
            await server.getUserVerificationStatus();
            hud.hide();
          });
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
                  child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Stack(children: [
                                    const SizedBox(height: 240, child: Header()),
                                    BalanceDisp(visible: false),
                                    Visibility(
                                      visible: true, 
                                      child: SafeArea(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 14),
                                              child: InkWell(
                                                onTap: () async {

                                                    await Future.wait([
                                                      server.sendRefreshToken(context)
                                                    ]).then((List<bool> value) async {
                                                      await server.getUserVerificationStatus();
                                                    });    

                                                    if(lstUsrVerfStat[0] == "success"){
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const KYC()));
                                                    }
                                                    else{
                                                      // ignore: use_build_context_synchronously
                                                      CustomDialog.okDialog(context, lstUsrVerfStat[2]);
                                                      if(lstUsrVerfStat[2] == "Verification is completed") {
                                                        setState(() {
                                                          verf = "1";  
                                                        });         
                                                      }
                                                    }
                                                },
                                                child:                                              
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [             
                                                      if (verf == "0") ...[         
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(15.0),
                                                            ),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                          child: Row( 
                                                            children: [
                                                              Image.asset("assets/Home/HomePP.png", width: adjustResolution(context, Resolution.normal.index, 15), height: adjustResolution(context, Resolution.normal.index, 15)),
                                                              Text("  KYC Pending ",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16),color: Colors.white, fontWeight: FontWeight.w600))),
                                                          ],)
                                                        ),
                                                      ],
                                                      if (verf == "1") ...[
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(15.0),
                                                            ),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                          child: Row( children: [
                                                            Image.asset("assets/Home/HomePP.png", width: adjustResolution(context, Resolution.normal.index, 15), height: adjustResolution(context, Resolution.normal.index, 15), color: Colors.white,),  
                                                            Text(" User Verified ",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16),color: Colors.white, fontWeight: FontWeight.w600))),
                                                          ],)
                                                        ),
                                                      ],
                                                    ],),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:100.0),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(personname.toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600, color: Colors.white)))
                                        ],),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(username.toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600, color: Colors.white)))
                                        ],)
                                      ],),
                                    )
              
                                ],)
                            ),
                            SliverToBoxAdapter(
                             child:                     
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Settings.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Settings",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14), color: Colors.black, fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){      
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SettingsToggle()));  
                                        },       
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),                      
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                             
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/ChangeName.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                           Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Update Name",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14), color: Colors.black, fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  () async {
                                          // ignore: use_build_context_synchronously
                                          final result = await Navigator.push(context,  MaterialPageRoute(builder: (context) =>  ChangeName()));
                                          setState(() {
                                            personname = result;
                                          });
              
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/ChangePassword.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Change Password",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const ChangePassword()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Commission.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Commission Rate",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) => const  CommissionRate()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Terms.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Terms and Conditions",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const TermsCondition()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Privacy.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Privacy Policy",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const PrivacyPolicy()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Register.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Register Dealer",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black ,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const RegisterDealer()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Icon(Icons.data_exploration_outlined, color: Colors.black, size: adjustResolution(context, Resolution.normal.index, 16)),
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Topup Report",style: GoogleFonts.figtree(textStyle:  TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  () {
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const TopupReport()));
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),                         
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/About.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),                                   
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" About",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  (){
                                        
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                             SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28, right: 36),
                                child: Divider(thickness: 1, color: Colors.grey.shade300,),
                              ),
                            ),  
                            SliverToBoxAdapter(
                             child:
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: ClipRRect(
                                  child: Stack(
                                    children: <Widget>[                              
                                      ElevatedButton.icon(
                                        icon: Image.asset("assets/Settings/Logout.png", width: adjustResolution(context, Resolution.normal.index, 14), height: adjustResolution(context, Resolution.normal.index, 14)),                                               
                                        label:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" Log Out",style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14),color: Colors.black,fontWeight: FontWeight.w500))),
                                              Icon(Icons.arrow_forward_ios,color: Colors.grey, size: adjustResolution(context, Resolution.normal.index, 16)),
                                            ],),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                        onPressed:  () async {
                                          CustomDialog.exitDialog(context, "Logging Out?"); 
                                        },              
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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


