import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/util/screenactivity.dart';
// import 'package:powerpay/util/messaging_service.dart';
import 'package:powerpay/widgets/header.dart';
import 'package:powerpay/widgets/balancedisplay.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/screens/receipt/receipt.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {       
    Color colorHotlink;   
    double bdrHotlink;
    bool pressedHotlink;
    Color colorXOX;   
    double bdrXOX;
    bool pressedXOX;
    Color colorDigi;   
    double bdrDigi;
    bool pressedDigi;
    Color colorCelcom;   
    double bdrCelcom;
    bool pressedCelcom;
    Color colorUMobile;   
    double bdrUMobile;
    bool pressedUMobile;
    Color colorTune;   
    double bdrTune;
    bool pressedTune;
    Color colorRedone;   
    double bdrRedone;
    bool pressedRedone;
    Color colorHellosim;   
    double bdrHellosim;
    bool pressedHellosim;
    Color colorHalotelco;   
    double bdrHalotelco;
    bool pressedHalotelco;
    Color colorBeone;   
    double bdrBeone;
    bool pressedBeone;
    Color colorYes;   
    double bdrYes;
    bool pressedYes;
    Color colorTonewow;   
    double bdrTonewow;
    bool pressedTonewow;
    bool active;
    String imageSelected;
    bool credit5pressed;
    bool credit10pressed;
    bool credit30pressed;
    bool credit50pressed;
    bool credit100pressed;
    int transMode; 
    bool visible;
    Color preBorder;
    Color amtBorder;

    //border button    
    Color colorRM5;
    Color colorRM10;
    Color colorRM15;
    Color colorRM20;
    Color colorRM30;
    Color colorRM50;
    Color colorRM80;
    Color colorRM90;
    Color colorRM100;

    //text
    Color txtColorRM5;
    Color txtColorRM10;
    Color txtColorRM15;
    Color txtColorRM20;
    Color txtColorRM30;
    Color txtColorRM50;
    Color txtColorRM80;
    Color txtColorRM90;
    Color txtColorRM100;


    Color colorManual;
    String enteredAmount;   
    String getLatestBalance;

    bool inactive; 
    bool hidden; 
    bool paused;
    bool detached;

    Home({
      super.key,      
      this.colorHotlink = transparent,      
      this.bdrHotlink = 0,
      this.colorXOX = transparent,   
      this.bdrXOX = 0,   
      this.colorDigi = transparent,   
      this.bdrDigi = 0,    
      this.colorCelcom = transparent,   
      this.bdrCelcom = 0,    
      this.colorUMobile = transparent,   
      this.bdrUMobile = 0,    
      this.colorTune = transparent,   
      this.bdrTune = 0,    
      this.colorRedone = transparent,   
      this.bdrRedone = 0,    
      this.colorHellosim = transparent,   
      this.bdrHellosim = 0,    
      this.colorHalotelco = transparent,   
      this.bdrHalotelco = 0,    
      this.colorBeone = transparent,   
      this.bdrBeone = 0,    
      this.colorYes = transparent,   
      this.bdrYes = 0,    
      this.colorTonewow = transparent,   
      this.bdrTonewow = 0,
      this.active = true,
      this.imageSelected = blankPng,
      this.pressedHotlink = false,
      this.pressedXOX = false,
      this.pressedDigi = false,
      this.pressedCelcom = false,
      this.pressedUMobile = false,
      this.pressedTune = false,
      this.pressedRedone = false,
      this.pressedHellosim = false,
      this.pressedHalotelco = false,
      this.pressedBeone = false,
      this.pressedYes = false,
      this.pressedTonewow = false,
      this.credit5pressed = false,
      this.credit10pressed = false,
      this.credit30pressed = false,
      this.credit50pressed = false,
      this.credit100pressed = false,
      this.transMode = 0,
      this.visible = false,
      this.preBorder = transparent,
      this.amtBorder = black38,
      this.colorRM5  = black38,
      this.colorRM10 = black38,
      this.colorRM15 = black38,
      this.colorRM20 = black38,
      this.colorRM30 = black38,
      this.colorRM50 = black38,
      this.colorRM80 = black38,
      this.colorRM90 = black38,
      this.colorRM100 = black38,
      this.txtColorRM5  = const Color(0xFF4C4C4C),
      this.txtColorRM10 = const Color(0xFF4C4C4C),
      this.txtColorRM15 = const Color(0xFF4C4C4C),
      this.txtColorRM20 = const Color(0xFF4C4C4C),
      this.txtColorRM30 = const Color(0xFF4C4C4C),
      this.txtColorRM50 = const Color(0xFF4C4C4C),
      this.txtColorRM80 = const Color(0xFF4C4C4C),
      this.txtColorRM90 = const Color(0xFF4C4C4C),
      this.txtColorRM100 = const Color(0xFF4C4C4C),
      this.colorManual = black38,
      this.enteredAmount = "",
      this.getLatestBalance = "",
      this.inactive = false,
      this.hidden = false,
      this.paused = false,
      this.detached = false,
    });

  @override
  State<Home> createState() => _HomeState();
}

enum SelectedAmount { 
  rm5(5), 
  rm10(10), 
  rm15(15), 
  rm20(20), 
  rm30(30), 
  rm50(50), 
  rm80(80), 
  rm90(90), 
  rm100(100);

  final int progress;
  const SelectedAmount(this.progress);
}

final amtController = TextEditingController();
final prepaidNumberController = TextEditingController();

FocusNode preNumControllerFocusNode = FocusNode();
FocusNode amtControllerFocusNode     = FocusNode();

class _HomeState extends ResumableState<Home> {
  
  late final Future _recentTrx = getHomeSetting();
  
  
  Future<void> getHomeSetting() async{
    await Future.wait([
      server.sendRefreshToken(context)
    ]).then((List<bool> value) async {
      await server.getRecentTransaction();
    });    
  }


  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    amtControllerFocusNode.addListener(() {
      if (amtControllerFocusNode.hasFocus) {
        amtController.clear();
        creditSelect(9);
      }
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

  bool isFirst = true;     
  double rotate = 0.0;

  @override
  Widget build(BuildContext context) {

  Map<String, dynamic> borderMap =  {
    hotlink : widget.bdrHotlink,
    celcom  : widget.bdrCelcom,
    digi    : widget.bdrDigi,
    umobile : widget.bdrUMobile,
    onexox  : widget.bdrXOX,
    tunetalk: widget.bdrTune,
    redone  : widget.bdrRedone,
    hellosim: widget.bdrHellosim,
    halotelco:widget.bdrHalotelco,
    beone   : widget.bdrBeone,
    yes     : widget.bdrYes,
    tonewow : widget.bdrTonewow
  };

  Map<String, dynamic> colorMap =  {
    hotlink   : widget.colorHotlink,
    celcom  : widget.colorCelcom,
    digi    : widget.colorDigi,
    umobile : widget.colorUMobile,
    onexox  : widget.colorXOX,
    tunetalk: widget.colorTune,
    redone  : widget.colorRedone,
    hellosim: widget.colorHellosim,
    halotelco:widget.colorHalotelco,
    beone   : widget.colorBeone,
    yes     : widget.colorYes,
    tonewow : widget.colorTonewow
  };


    return Sizer(
      
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {  
         
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            color: Colors.blue,
            backgroundColor: Colors.white,
            onRefresh: () async {
              setState(() {
                getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
              });
              hud.show();
              await Future.wait([
                server.sendRefreshToken(context)
              ]).then((List<bool> value) async {
                await server.getSetting(context);
                await server.getRecentTransaction();
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
                                child: Stack(children: <Widget>[
                                    const SizedBox(height: 280, child: Header()),
                                    BalanceDisp(visible: true),
                                    Padding(
                                      padding: const EdgeInsets.only( top: 189, left: 0, right: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 68,
                                            width: 90.w,
                                            decoration: BoxDecoration(              
                                              boxShadow:  [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 6,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                              color: white,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget> [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 30, top: 11.5),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              // CustomDialog.testDialog(context);
                                                            },
                                                            child: Image.asset("assets/Home/HomePP.png", width: adjustResolution(context, Resolution.normal.index, 30), height: adjustResolution(context, Resolution.normal.index, 30))
                                                            
                                                          ),
                                                          Text("\t\t\t+60",   style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 22), fontWeight: FontWeight.w600, fontFamily: 'Figtree', color: const Color(0xFF333333)))),
                                                          Text("\t\t\t|\t\t\t",   style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 22), fontWeight: FontWeight.w400, fontFamily: 'Figtree', color: const Color(0xFF257CCE)))),
                                                          SizedBox(
                                                            height: 40,
                                                            width: 40.w,
                                                            child: TextField(
                                                              cursorHeight: 24.sp,     
                                                              decoration: InputDecoration(
                                                                contentPadding: const EdgeInsets.only(top:-12),
                                                                focusedBorder: UnderlineInputBorder(                        
                                                                    borderSide: BorderSide(
                                                                      width: 1, color: widget.preBorder,                          
                                                                    )
                                                                ),
                                                                enabledBorder: UnderlineInputBorder(                        
                                                                    borderSide: BorderSide(
                                                                      width: 1, color: widget.preBorder,                          
                                                                    )
                                                                ),
                                                                hintMaxLines: 10,
                                                                hintText: 'Phone Number',   
                                                                hintStyle: GoogleFonts.figtree(textStyle:  TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: adjustResolution(context, Resolution.normal.index, 18),
                                                                    color: black38,
                                                                  ),
                                                                ),
                                                                counterText: ""
                                                              ),
                                                                style: GoogleFonts.figtree(textStyle: TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: adjustResolution(context, Resolution.normal.index, 22), 
                                                                  color: const Color(0xFF333333),
                                                                ),
                                                                ),
                                                                keyboardType: const TextInputType.numberWithOptions(
                                                                  decimal: false,
                                                                  signed: false
                                                                ),                                                     
                                                                maxLength: 10,
                                                                controller: prepaidNumberController,
                                                                focusNode: preNumControllerFocusNode,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                                                                    
                                                  ],
                                                ),                
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  
                                    ],) 
                              ),
                              
                              SliverToBoxAdapter(                      
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 22, right: 0),
                                    child: ExpansionPanelList(
                                      
                                      dividerColor: Colors.white,
                                      elevation: 0,
                                      expansionCallback: (panelIndex, isExpanded){
                                        widget.active = !widget.active;                              
                                        setState(() {
                                          ///
                                        });
                                      },
                                      children: <ExpansionPanel>[
                                        ExpansionPanel(
                                          backgroundColor: Colors.transparent,
                                          headerBuilder: ((context, isExpanded) {
                                              return Row(
                                                children: <Widget> [
                                                Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                                Text("  Select Telco Operator  ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),)),
                                                Visibility(
                                                  visible: (widget.imageSelected == blankPng)? false: true,
                                                  child: Container(                                                              
                                                      height: adjustResolution(context, Resolution.normal.index, 40),
                                                      width: adjustResolution(context, Resolution.normal.index, 60),
                                                      decoration: BoxDecoration(
                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                    image: DecorationImage(
                                                                      image: AssetImage(widget.imageSelected),
                                                                      fit: BoxFit.fitHeight
                                                                    )
                                                                  )
                                                    ),
                                                ),
                                                Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                              ],);
                                          }), 
                                          body: Wrap( 
                                              children: <Widget>[

                                                for(int i=0; i<telcos.length; i++)...[
                                                
                                                  InkWell(
                                                    child: Padding(
                                                      padding: EdgeInsets.only( right: adjustResolution(context, Resolution.container.index, 18), bottom: adjustResolution(context, Resolution.container.index, 14)),
                                                      child: Column(
                                                        children: [
                                                          Container(   
                                                            height: adjustResolution(context, Resolution.container.index, 86),
                                                            width: adjustResolution(context, Resolution.container.index, 80),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: colorMap[telcos[getIndexOf(i)].toString()], width: borderMap[telcos[i].toString()] ),
                                                              image:  DecorationImage(
                                                                        image: AssetImage(imageMap[telcos[getIndexOf(i)]].toString()),
                                                                        fit: BoxFit.fill
                                                                      ),                                                              
                                                              shape: BoxShape.circle
                                                            ),
                                                          ),
                                                          Text(textMap[telcos[getIndexOf(i)].toString()]!, style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: const Color(0xFF75757A))),)
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      setState(() {
                                                          Telco.onexox.index;
                                                          setSelection(telcos[i].toString());
                                                          if(widget.visible == false) widget.visible = true;
                                                          widget.active = false;                                                                
                                                      });
                                                    },
                                                  ),
                                                ]                                  
                                              ],
                                          ),
                                          isExpanded: widget.active, 
                                          canTapOnHeader: true
                                        ) 
                                      ],
                                    ),
                                  )
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 20)),            
                              SliverToBoxAdapter(
                                child: Column(children: [                            
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2, right: 4),
                                        child: Visibility(
                                          visible: widget.visible,
                                          child: Column(children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [                                    
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Ink(
                                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: adjustResolution(context, Resolution.container.index, 110),
                                                      height: adjustResolution(context, Resolution.container.index, 45),
                                                      decoration: 
                                                        BoxDecoration(
                                                          color: transparent, 
                                                          border: Border.all( color: widget.colorRM5, width: 2),
                                                          borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                        ),
                                                      child: Text("RM5", style: GoogleFonts.figtree(textStyle: TextStyle(color: widget.txtColorRM5, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),                                      
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm5.index);
                                                      var amount = double.parse(SelectedAmount.rm5.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);                                          
                                                    });
                                                  } 
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Row(
                                                    children: [                                          
                                                      Container(
                                                        alignment: Alignment.center,
                                                        width: adjustResolution(context, Resolution.container.index, 110),
                                                      height: adjustResolution(context, Resolution.container.index, 45),
                                                        decoration: 
                                                          BoxDecoration(
                                                            color: transparent, 
                                                            border: Border.all( color: widget.colorRM10, width: 2),
                                                            borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                          ),
                                                        child: Text("RM10", style: GoogleFonts.figtree(textStyle: TextStyle(color: widget.txtColorRM10, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm10.index);
                                                      var amount = double.parse(SelectedAmount.rm10.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  } ,
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM15, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM15", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM15, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm15.index);
                                                      var amount = double.parse(SelectedAmount.rm15.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                              ],),
                                            const SizedBox(height: 15,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM20, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM20", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM20, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm20.index);
                                                      var amount = double.parse(SelectedAmount.rm20.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM30, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM30", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM30, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm30.index);
                                                      var amount = double.parse(SelectedAmount.rm30.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM50, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM50", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM50, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm50.index);
                                                      var amount = double.parse(SelectedAmount.rm50.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                            ],),
                                            const SizedBox(height: 15,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM80, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM80", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM80, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm80.index);
                                                      var amount = double.parse(SelectedAmount.rm80.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM90, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM90", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM90, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm90.index);
                                                      var amount = double.parse(SelectedAmount.rm90.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                                InkWell(
                                                  customBorder: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: adjustResolution(context, Resolution.container.index, 110),
                                                    height: adjustResolution(context, Resolution.container.index, 45),
                                                    decoration: 
                                                      BoxDecoration(
                                                        color: transparent, 
                                                        border: Border.all( color: widget.colorRM100, width: 2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),  
                                                      ),
                                                    child: Text("RM100", style: GoogleFonts.figtree(textStyle:TextStyle(color: widget.txtColorRM100, fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 18)))),
                                                  ),
                                                  onTap: (){
                                                    setState(() {
                                                      creditSelect(SelectedAmount.rm100.index);
                                                      var amount = double.parse(SelectedAmount.rm100.progress.toString());
                                                      amtController.text = amount.toStringAsFixed(0);
                                                    });
                                                  }
                                                ),
                                            ],),                          
                                          ],)
                                        ),
                                      ),
                                ],)
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 20)),
                              SliverToBoxAdapter(
                                child:
                                  Padding(
                                    padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 30), right: adjustResolution(context, Resolution.normal.index, 30)),
                                    child: Visibility(
                                      visible: widget.visible,
                                      child: SizedBox(
                                              height: adjustResolution(context, Resolution.normal.index, 40),
                                              width: adjustResolution(context, Resolution.normal.index, 100),
                                              child: TextField(                                                                            
                                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                                                onChanged: (value) {
                                                  creditSelect(9);
                                                },
                                                // focusNode: amtControllerFocusNode,
                                                controller: amtController, 
                                                textAlign: TextAlign.center,
                                                decoration:  InputDecoration(
                                                  contentPadding: const EdgeInsets.all(0),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 3, color: widget.colorManual,                                            
                                                      )
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color:widget.colorManual, width:1),                                        
                                                  ),                                     
                                                  hintText:  "Enter Amount",                                        
                                                  prefixText: (amtController.text == "")? "": " RM" ,                                       
                                                  prefixStyle: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 24), fontWeight: FontWeight.bold, color: const Color(0xFF4C4C4C),)),
                                                  hintMaxLines: 8,                         
                                                  hintStyle: GoogleFonts.figtree(textStyle: TextStyle(                                                        
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: adjustResolution(context, Resolution.normal.index, 24),
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                  counterText: "",
                                                ),
                                                style: GoogleFonts.figtree(textStyle:  TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: adjustResolution(context, Resolution.normal.index, 24),
                                                    color: const Color(0xFF4C4C4C),
                                                  )
                                                ),
                                                keyboardType: TextInputType.number,
                                                maxLength: 10,
                                                onTap:  (){                                  
                                                  setState(() {
                                                                                          
                                                  });
                                                },
                                              ),
                                            ),
                                    ),
                                  )
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 20)),
                              SliverToBoxAdapter(
                              child:
                                Visibility(
                                  visible: widget.visible,
                                  child: 
                                    Padding(
                                      // padding: const EdgeInsets.only(left:28, right: 24),
                                      padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 30), right: adjustResolution(context, Resolution.normal.index, 30)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),    
                                        child: Stack(
                                          children: <Widget>[
                                            TextButton(                                
                                              style: TextButton.styleFrom(
                                                backgroundColor: const Color(0xFF03033C),
                                                foregroundColor: white,
                                                fixedSize: Size(
                                                  adjustResolution(context, Resolution.normal.index, 400),
                                                  adjustResolution(context, Resolution.normal.index, 44)),                           
                                              ),
                                              child: Text('Reload',style:TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20))),                        
                                              onPressed: () async {         
                  
                                                  
                  
                                                  //format string amount to be sent, clear off all the commas
                                                  var reloadAmt = amtController.text.replaceAll(',', '').toString(); 
                  
                                                  //TODO: Get the max reload amount from server and setup condition here
                                                  // if reloadAmt > maxReloadAmt ... Deny reload  
                  
                                                  if( (prepaidNumberController.text.isEmpty && (amtController.text.isEmpty || amtController.text.isNotEmpty)) ){
                                                    
                                                    // CustomDialog.testDialog(context, descripstions)
                                                    CustomDialog.okDialog(context, "Please enter the \n prepaid number to reload.");
                                                    widget.preBorder = Colors.red;
                                                    widget.colorManual = transparent;                                      
                                                    FocusScope.of(context).requestFocus(preNumControllerFocusNode);                              
                                                  
                                                  }else if(prepaidNumberController.text.isNotEmpty && amtController.text.isEmpty){
                                                  
                                                    CustomDialog.okDialog(context, "Please select or enter \n the amount to reload.");
                                                    widget.preBorder = Colors.transparent;
                                                    widget.colorManual = Colors.red;
                                                    FocusScope.of(context).requestFocus(amtControllerFocusNode);
                                                                                          
                                                  }
                                                  if(prepaidNumberController.text.substring(0,2) == "01"){
                                                    
                                                    CustomDialog.okDialog(context, "Kindly remove the first '0' \n from the phone number");
                                                  
                                                  }else if(double.parse(reloadAmt) > double.parse(getLatestBalance)){
                                                  
                                                    CustomDialog.cancelDialog(context, "Insufficient credit.");
                                                  
                                                  }else if(prepaidNumberController.text.isNotEmpty && amtController.text.isNotEmpty){
                                                  
                                                    widget.preBorder = Colors.transparent;
                                                    widget.colorManual = Colors.black38;
                                                    
                                                    hud.show();

                                                    //TOPUP PURCHASE
                                                    await Future.wait([
                                                      server.sendRefreshToken(context)
                                                    ]).then((List<bool> value) async {
                                                      List topupMsg = await server.topupPurchase(widget.transMode.toString(), reloadAmt.toString(), prepaidNumberController.text);
                                                      if(topupMsg[0] == true){                                                    
                                                        await Future.wait([
                                                          server.getBalance(),
                                                          server.getRecentTransaction(),  
                                                        ]).then((List<bool> value) async {
                                                          //Update balance
                                                          setState(() {
                                                            getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
                                                          });
                                                        });
                                                        hud.hide();
                                                        
                                                        // ignore: use_build_context_synchronously
                                                        CustomDialog.okDialog(context, "Reload Success: \n RM${amtController.text} added to 0${prepaidNumberController.text}");
                                                        
                                                      }else if(topupMsg[0] == false){
                                                        hud.hide();
                                                        // ignore: use_build_context_synchronously
                                                        CustomDialog.cancelDialog(context, "Reload not successful.\n Reason: ${topupMsg[3]}");
                                                      }
                                                    });
                                                  }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ),
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 25)),  
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 26), right: adjustResolution(context, Resolution.normal.index, 30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                      Text(
                                        '  Recent Transaction  ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          // fontSize: adjustResolution(context, Resolution.normal.index, 19),
                                          fontSize: 14.sp,
                                          color: black,
                                        ),
                                      ),
                                      InkWell(
                                        child: AnimatedRotation(
                                          turns: rotate,
                                          duration: const Duration(seconds: 1),
                                          child: const Icon(Icons.refresh)),
                                        onTap: () async {
                                          await Future.wait([
                                            server.sendRefreshToken(context)
                                          ]).then((List<bool> value) async {
                                            await server.getRecentTransaction();
                                          });
                                          
                                          setState(() {
                                            rotate += 1;
                                          });                 
                                        },
                                      ),
                                      const Text("  "), 
                                      Expanded(child: Divider(height: 0, color: Colors.grey.shade400),),
                                      
                                    ]
                                  ),
                                ),
                              ),
                              
                              FutureBuilder(
                                future: _recentTrx,
                                builder: (context, projectSnap){
                                  if (projectSnap.connectionState == ConnectionState.none &&
                                        // ignore: unnecessary_null_comparison
                                        projectSnap.hasData == null) {
                                    //print('project snapshot data is: ${projectSnap.data}');
                                    return Container();
                                  }
            
                                  return SliverList.builder(
                                    itemCount: lstRectrans.r.length,
                                    itemBuilder: (context, index){
                                      final item = lstRectrans.r[index];
                                      return Padding(                                    
                                        padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 10), right: adjustResolution(context, Resolution.normal.index, 6)),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              visualDensity: Platform.isAndroid? 
                                                              const VisualDensity(horizontal: 0, vertical: -2)
                                                                : const VisualDensity(horizontal: 0, vertical: 0),
                                              isThreeLine: true,
                                              title: Text(item['Date'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 10), color: Colors.grey, fontWeight: FontWeight.bold))),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${item['Description'].toString().toUpperCase()} ${item['TrxType'].toString().toUpperCase()}: ${item['RefNo']}", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: adjustResolution(context, Resolution.normal.index, 13)))),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Text("REFID: ${(item['RefNo2'].toString() == "null")?"":item['RefNo2'].toString().toUpperCase()}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 10), fontWeight: FontWeight.bold))),
                                                ],)
                                                ],
                                              ),
                                              tileColor: transparent,
                                              trailing: 
                                                SizedBox(
                                                  width: 100,                                    
                                                  child: Column(                                      
                                                    children: <Widget>[
                                                      const SizedBox(height:10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          if(item['StatusID'].toString() == "0") Text("RM ${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, color: black, fontSize: adjustResolution(context, Resolution.normal.index, 13)))),
                                                          if(item['StatusID'].toString() == "1") Text("RM ${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, color: themeColor, fontSize: adjustResolution(context, Resolution.normal.index, 13)))),
                                                          if(item['StatusID'].toString() == "2") Text("RM ${double.parse(item['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: adjustResolution(context, Resolution.normal.index, 13)))),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          if(item['StatusID'].toString() == "0") Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey , fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                          if(item['StatusID'].toString() == "1") Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: themeColor , fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                          if(item['StatusID'].toString() == "2") Text(item['Status'].toString(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.red , fontSize: adjustResolution(context, Resolution.normal.index, 12)))),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              onTap: () async {
                                                await Future.wait([
                                                  server.sendRefreshToken(context)
                                                ]).then((List<bool> value) async {
                                                  await server.getTopupDetail(item['ProductPurchaseID'].toString());
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,  MaterialPageRoute(builder: (context) =>  const Receipt())); 
                                                });     
                                              }
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                              child: Divider(height: 0, color: Colors.grey.shade300),
                                            ),
                                          ],
                                          
                                        ),
                                      );    
                                    });
                                }),
                            ],
                          )
                  );
                }
              ),
            ),
          ),
        );
      
      },
      
      
    );
  }


  void setSelection(String value){

      widget.active = false;      
      
      //For transaction/API call usage
      //Get the product ID for selected Telco for transaction purpose
      widget.transMode = productId[getProductIdIndex(value)]; 
      
      switch(value){        
        case hotlink:           
          widget.imageSelected = imageHotlink;
          widget.colorHotlink = highlight;
          widget.bdrHotlink = (widget.bdrHotlink == 0)? adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedHotlink = true;

          widget.pressedBeone     = 
          widget.pressedCelcom    = 
          widget.pressedDigi      = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedTune      =
          widget.pressedUMobile   =
          widget.pressedXOX       =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorCelcom      = 
          widget.colorDigi        = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorTune        =
          widget.colorUMobile     =
          widget.colorXOX         =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone      = 
          widget.bdrCelcom      = 
          widget.bdrDigi        = 
          widget.bdrHalotelco   = 
          widget.bdrHellosim    =
          widget.bdrRedone      = 
          widget.bdrTonewow     = 
          widget.bdrTune        =
          widget.bdrUMobile     =
          widget.bdrXOX         =
          widget.bdrYes         = 
            0.0;
        break;
        case celcom:          
          widget.imageSelected = imageCelcom;
          widget.colorCelcom = highlight;
          widget.bdrCelcom = (widget.bdrCelcom == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedCelcom = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedDigi      = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedTune      =
          widget.pressedUMobile   =
          widget.pressedXOX       =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorDigi        = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorTune        =
          widget.colorUMobile     =
          widget.colorXOX         =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrDigi      = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrRedone    = 
          widget.bdrTonewow   = 
          widget.bdrTune      =
          widget.bdrUMobile   =
          widget.bdrXOX       =
          widget.bdrYes       = 
            0.0;
        break;
        case digi:           
          widget.imageSelected = imageDigi;
          widget.colorDigi = highlight;
          widget.bdrDigi = (widget.bdrDigi == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedDigi = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedTune      =
          widget.pressedUMobile   =
          widget.pressedXOX       =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorTune        =
          widget.colorUMobile     =
          widget.colorXOX         =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrRedone    = 
          widget.bdrTonewow   = 
          widget.bdrTune      =
          widget.bdrUMobile   =
          widget.bdrXOX       =
          widget.bdrYes       = 
            0.0;
        break;
        case umobile:           
          widget.imageSelected = imageUMobile;
          widget.colorUMobile = highlight;
          widget.bdrUMobile = (widget.bdrUMobile == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedUMobile = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedTune      =
          widget.pressedDigi      =
          widget.pressedXOX       =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorTune        =
          widget.colorDigi        =
          widget.colorXOX         =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrRedone    = 
          widget.bdrTonewow   = 
          widget.bdrTune      =
          widget.bdrDigi      =
          widget.bdrXOX       =
          widget.bdrYes       = 
            0.0;
        break;
        case onexox:           
          widget.imageSelected = imageXOX;
          widget.colorXOX = highlight;
          widget.bdrXOX = (widget.bdrXOX == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedXOX = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedTune      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorTune        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrRedone    = 
          widget.bdrTonewow   = 
          widget.bdrTune      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0;
        break;
        case tunetalk:
          widget.imageSelected = imageTune;
          widget.colorTune = highlight;
          widget.bdrTune = (widget.bdrTune == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedTune = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedRedone    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorRedone      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrRedone    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0;
          break;
        case redone:
          widget.imageSelected = imageRedone;
          widget.colorRedone = highlight;
          widget.bdrRedone = (widget.bdrRedone == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedRedone = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedHellosim  = 
          widget.pressedTune    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorHellosim    = 
          widget.colorTune      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrHellosim  =
          widget.bdrTune    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0; 
          break;
        case hellosim:
          widget.imageSelected = imageHellosim;
          widget.colorHellosim = highlight;
          widget.bdrHellosim = (widget.bdrHellosim == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedHellosim = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHalotelco =
          widget.pressedRedone  = 
          widget.pressedTune    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHalotelco   = 
          widget.colorRedone    = 
          widget.colorTune      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrBeone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHalotelco = 
          widget.bdrRedone  =
          widget.bdrTune    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0;
          break;
        case halotelco:
          widget.imageSelected = imageHaloTelco;
          widget.colorHalotelco = highlight;
          widget.bdrHalotelco = (widget.bdrHalotelco == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedHalotelco = true;

          widget.pressedBeone     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHellosim =
          widget.pressedRedone  = 
          widget.pressedTune    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorBeone       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHellosim   = 
          widget.colorRedone    = 
          widget.colorTune      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrRedone    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHellosim = 
          widget.bdrRedone  =
          widget.bdrTune    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0; 
          break;
        case beone:
          widget.imageSelected = imageBeone;
          widget.colorBeone = highlight;
          widget.bdrBeone = (widget.bdrHalotelco == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedBeone = true;

          widget.pressedHalotelco     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHellosim =
          widget.pressedRedone  = 
          widget.pressedTune    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedYes       = 
            false;

          widget.colorHalotelco       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHellosim   = 
          widget.colorRedone    = 
          widget.colorTune      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorYes         = 
            transparent ;
          
          widget.bdrHalotelco    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHellosim = 
          widget.bdrRedone  =
          widget.bdrTune    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrYes       = 
            0.0; 
          break;
        case yes:
          widget.imageSelected = imageYes;
          widget.colorYes = highlight;
          widget.bdrYes = (widget.bdrYes == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedYes = true;

          widget.pressedHalotelco     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHellosim =
          widget.pressedRedone  = 
          widget.pressedTune    = 
          widget.pressedTonewow   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedBeone       = 
            false;

          widget.colorHalotelco       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHellosim   = 
          widget.colorRedone    = 
          widget.colorTune      = 
          widget.colorTonewow     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorBeone         = 
            transparent ;
          
          widget.bdrHalotelco    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHellosim = 
          widget.bdrRedone  =
          widget.bdrTune    = 
          widget.bdrTonewow   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrBeone       = 
            0.0;
          break; 
        case tonewow:
          widget.imageSelected = imageTonewow;
          widget.colorTonewow = highlight;
          widget.bdrTonewow = (widget.bdrTonewow == 0)?adjustResolution(context, Resolution.normal.index, 6):0;
          widget.pressedTonewow = true;

          widget.pressedHalotelco     = 
          widget.pressedHotlink     = 
          widget.pressedCelcom    = 
          widget.pressedHellosim =
          widget.pressedRedone  = 
          widget.pressedTune    = 
          widget.pressedYes   = 
          widget.pressedXOX      =
          widget.pressedDigi      =
          widget.pressedUMobile   =
          widget.pressedBeone       = 
            false;

          widget.colorHalotelco       = 
          widget.colorHotlink       = 
          widget.colorCelcom      = 
          widget.colorHellosim   = 
          widget.colorRedone    = 
          widget.colorTune      = 
          widget.colorYes     = 
          widget.colorXOX        =
          widget.colorDigi        =
          widget.colorUMobile     =
          widget.colorBeone         = 
            transparent ;
          
          widget.bdrHalotelco    = 
          widget.bdrHotlink     = 
          widget.bdrCelcom    = 
          widget.bdrHellosim = 
          widget.bdrRedone  =
          widget.bdrTune    = 
          widget.bdrYes   = 
          widget.bdrXOX      =
          widget.bdrDigi      =
          widget.bdrUMobile   =
          widget.bdrBeone       = 
            0.0;
          break;  
      }
  }

  void creditSelect(int index){
    widget.active = false; 

    switch(index){
      case 0:
        //RM5
        widget.colorRM5 = blue;

        widget.colorRM10    = 
        widget.colorRM15    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38; 

        widget.txtColorRM5 = blue;

        widget.txtColorRM10    = 
        widget.txtColorRM15    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);   
        break;
      case 1:
        //RM10
        widget.colorRM10 = blue;

        widget.colorRM5     = 
        widget.colorRM15    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38;

        widget.txtColorRM10 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM15    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);    
        break;
      case 2: 
        //RM15
        widget.colorRM15 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38;

        widget.txtColorRM15 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);    
        break;
      case 3:
        //RM20
        widget.colorRM20 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   =
        widget.colorManual  = 
          black38;

        widget.txtColorRM20 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   =
          const Color(0xFF4C4C4C);    
        break;
      case 4: 
        //RM30
        widget.colorRM30 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    =  
        widget.colorRM20    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38;  

        widget.txtColorRM30 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    =  
        widget.txtColorRM20    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);    
        break;
      case 5: 
        //RM50
        widget.colorRM50 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorRM100   =  
        widget.colorManual  = 
          black38;

        widget.txtColorRM50 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   =  
          const Color(0xFF4C4C4C);    
        break;
      case 6: 
        //RM80
        widget.colorRM80 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM90    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38;

        widget.txtColorRM80 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);    
        break;
      case 7: 
        //RM90
        widget.colorRM90 = blue;
        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    = 
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM100   = 
        widget.colorManual  = 
          black38;

        widget.txtColorRM90 = blue;
        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    = 
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM100   = 
          const Color(0xFF4C4C4C);    
        break;
      case 8: 
        //RM100
        widget.colorRM100 = blue;

        widget.colorRM5     = 
        widget.colorRM10    = 
        widget.colorRM15    =  
        widget.colorRM20    = 
        widget.colorRM30    = 
        widget.colorRM50    = 
        widget.colorRM80    = 
        widget.colorRM90    = 
        widget.colorManual  = 
          black38;

        widget.txtColorRM100 = blue;

        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    =  
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
         const Color(0xFF4C4C4C);    
        break;
      case 9: 
        //Manual Amount
        widget.colorManual = blue;
        widget.colorRM5   = 
        widget.colorRM10  = 
        widget.colorRM15  = 
        widget.colorRM20  = 
        widget.colorRM30  = 
        widget.colorRM50  = 
        widget.colorRM80  = 
        widget.colorRM90  = 
        widget.colorRM100 = 
          black38;  

        
        widget.txtColorRM5     = 
        widget.txtColorRM10    = 
        widget.txtColorRM15    =  
        widget.txtColorRM20    = 
        widget.txtColorRM30    = 
        widget.txtColorRM50    = 
        widget.txtColorRM80    = 
        widget.txtColorRM90    = 
        widget.txtColorRM100   =
        const Color(0xFF4C4C4C);
        break;
      default:
        //Clear all
        widget.colorManual = blue;

        widget.colorRM5   = 
        widget.colorRM10  = 
        widget.colorRM15  = 
        widget.colorRM20  = 
        widget.colorRM30  = 
        widget.colorRM50  = 
        widget.colorRM80  = 
        widget.colorRM90  = 
        widget.colorRM100 = 
          black38;
        break;
    }
   
  }
  
}