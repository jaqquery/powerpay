import 'package:flutter/material.dart';
import 'package:powerpay/util/hud.dart';
import 'package:powerpay/util/messaging_service.dart';
import 'package:powerpay/util/server.dart';
import 'package:powerpay/util/serverresponse.dart';

//HUD Global instance 
final hud = HUD();

//call server api etc
Server server = Server();

//Home theme color
const Color white           = Colors.white;
const Color black           = Colors.black;
const Color black38         = Colors.black38; 
const Color blue            = Colors.blue;
const Color green           = Colors.green; 
const Color transparent     = Colors.transparent;
const Color themeColor      = Color(0xFF1976D2);
const Color buttonColor     = Color(0xFF03033C);
Color highlight             = Colors.grey.shade400; 

//KYC
const String icFront   = "assets/ic_f.png";
const String icBack    = "assets/ic_b.png";
const String icSelfie  = "assets/ic_s.png";

const String apiDomain    = "https://devapi.powerpay.my";
const String apiPayDomain = "https://devapi.powerpay.my";

//business data
const String businessRegNum = "1547939P  ";
final String recpRef        = username;
final String otherPayDet    = username;

//official telco image
const String imageXOX      = "assets/TelcoLogos/01_Onexox.png";
const String imageHotlink  = "assets/TelcoLogos/02_Hotlink.png";
const String imageDigi     = "assets/TelcoLogos/03_Digi.png";
const String imageCelcom   = "assets/TelcoLogos/04_Celcom.png";
const String imageUMobile  = "assets/TelcoLogos/05_UMobile.png";
const String imageTune     = "assets/TelcoLogos/06_TuneTalk.png";
const String imageRedone   = "assets/TelcoLogos/07_Redone.png";
const String imageHellosim = "assets/TelcoLogos/08_Hellosim.png";
const String imageHaloTelco= "assets/TelcoLogos/09_HaloTelco.png";
const String imageBeone    = "assets/TelcoLogos/10_Beone.png";
const String imageYes      = "assets/TelcoLogos/11_Yes.png";
const String imageTonewow  = "assets/TelcoLogos/12_Tonewow.png";
const String blankPng      = "assets/Empty.png";

//official powerpay logo
const String ppLogoGradHorPng = "assets/Powerpay_Logo/Gradient Colour/Logo_Horizontal.png";
const String ppLogoGradHorSvg = "assets/Powerpay_Logo/Gradient Colour/Logo_Horizontal.svg";
const String ppLogoGradVerPng = "assets/Powerpay_Logo/Gradient Colour/Logo_Vertical.png";
const String ppLogoGradVerSvg = "assets/Powerpay_Logo/Gradient Colour/Logo_Vertical.svg";
const String ppLogoGradVerIcoPng = "assets/Powerpay_Logo/Gradient Colour/Logo_icon.png";
const String ppLogoGradVerIcoSvg = "assets/Powerpay_Logo/Gradient Colour/Logo_icon.svg";
const String ppLogoGradWhiteHorPng ="assets/Powerpay_Logo/Gradient White Colour/Logo_Horizontal.png";
const String ppLogoGradWhiteHorSvg = "assets/Powerpay_Logo/Gradient White Colour/Logo_Horizontal.svg";
const String ppLogoGradWhiteVerPng = "assets/Powerpay_Logo/Gradient White Colour/Logo_Vertical.png";
const String ppLogoGradWhiteVerSvg = "assets/Powerpay_Logo/Gradient White Colour/Logo_Vertical.svg";
const String ppLogoWhiteHorPng = "assets/Powerpay_Logo/White Colour/Logo_Horizontal.png";
const String ppLogoWhiteHorSvg = "assets/Powerpay_Logo/White Colour/Logo_Horizontal.svg";
const String ppLogoWhiteVerPng = "assets/Powerpay_Logo/White Colour/Logo_Vertical.png";
const String ppLogoWhiteVerSvg = "assets/Powerpay_Logo/White Colour/Logo_Vertical.svg";
const String ppLogoWhiteVerIcoPng = "assets/Powerpay_Logo/White Colour/Logo_icon.png";
const String ppLogoWhiteVerIcoSvg = "assets/Powerpay_Logo/White Colour/Logo_icon.svg";

//resolution variables
//standard, login
double mediaWidth = 0;
double szLabelText = 0;

//token timestamp check
DateTime expiredTimeCheck = DateTime.now();
// DateTime expiredTimeCheck = DateTime.now().add(const Duration(minutes: intDefaultMinTime));

const int intDefaultMin = 60;
const String strExpTime = "expiredTimeCheck";

Future<void> setExpiryTimeInMinutes(int min) async {
  expiredTimeCheck = DateTime.now().add(Duration(minutes: min));
  await server.writeSecureData(strExpTime, expiredTimeCheck.toString());
}

final messagingService = MessagingService();

//Notification grouping
const String groupKey = 'com.powerpay.powerpay';

//balancedisplay
String getLatestBalance = "";

//for login error message
var errLoginMsg = "";

//for secure data storage purposes
var username = "";
var personname = "";
var acctbal = "";
var notf = "";
var verf = "";
var ptypeid = "";

//For record of transaction with list
RespondedList lstRectrans     = RespondedList(r: []);
RespondedList lstTrxHistory   = RespondedList(r: []);
RespondedList lstBalReport    = RespondedList(r: []);
RespondedList lstTopupReport  = RespondedList(r: []);
RespondedList lstMessages     = RespondedList(r: []);
Bank bank = Bank();
Setting settings = Setting();


// ignore: prefer_typing_uninitialized_variables
var vBalDetails;
// ignore: prefer_typing_uninitialized_variables
var vTopupDetails;

//List value to be returned from function 
List lstUsrVerfStat = [];
List lstUsrVerfResponse = [];

//Settings
//from ProductList header 
List prodlist = [];
//subcategory of ProductList 
List telcos = [];
List productId =[];
List productCategoryId =[];
List productCategory =[];
List commissionType = [];
List commissionRates = [];
List orderNum = [];
//for FPX balance Reload
double minFpxDepositAmount = 0;


const String hotlink  = 'Hotlink';
const String celcom   = 'Celcom';
const String digi     = 'Digi';
const String umobile  = 'UMobile';
const String onexox   = 'ONEXOX';
const String tunetalk = 'TuneTalk';
const String redone   = 'RedONE';
const String hellosim = 'HelloSim';
const String halotelco= 'Halo Telco';
const String beone    = 'Beone';
const String yes      = 'Yes';
const String tonewow  = 'Tonewow';

//text mapping
const Map<String,String> textMap = {
  hotlink : "Hotlink",
  celcom  : "Celcom",
  digi    : "Digi",
  umobile : "UMobile",
  onexox  : "OneXOX",
  tunetalk: "TuneTalk",
  redone  : "RedONE",
  hellosim: "HelloSIM",
  halotelco: "HaloTelco",
  beone   : "Beone",
  yes     : "Yes",
  tonewow : "ToneWow"
};


//image mapping
//For Home and Commission ua
const Map<String,String> imageMap = {
  hotlink : imageHotlink,
  celcom  : imageCelcom,
  digi    : imageDigi,
  umobile : imageUMobile,
  onexox  : imageXOX,
  tunetalk: imageTune,
  redone  : imageRedone,
  hellosim: imageHellosim,
  halotelco: imageHaloTelco,
  beone   : imageBeone,
  yes     : imageYes,
  tonewow : imageTonewow
};

//for notification status
bool nStat = false;

//TEST
Map<int,String> prodIdTelco = {};
// var sortedKeys;

enum Telco {
  onexox(1),
  hotlink(2),
  digi(3),
  celcom(4),
  umobile(5),
  tunetalk(6),
  redone(7),
  hellosim(8),
  halotelco(9),
  beone(10),
  yes(11),
  tonewow(12);

  final int productId;
  const Telco(this.productId);
}

List<ProductListElement> clsProductList = List.empty();

class ProductListElement {
    int productId;
    int productCategoryId;
    String productCategory;
    String description;
    String commissionType;
    double commissionRate;
    int orderNum;

    ProductListElement({
        required this.productId,
        required this.productCategoryId,
        required this.productCategory,
        required this.description,
        required this.commissionType,
        required this.commissionRate,
        required this.orderNum,
    });

}

const snackBarExitMsg = SnackBar(content: Text('Swipe back again to exit'));

const List<String> filterDays = <String>['Last 90 Days', 'Last 30 Days', 'Last 7 Days', 'Yesterday', 'Today'];

//arrange by orderNum
int getIndexOf(dynamic value) {

  int index =  prodlist.indexWhere((item) => item.orderNum == value);  
  return ++index;
}

int getProductIdIndex(String arrProdName){
  return telcos.indexOf(arrProdName);
}

enum Resolution {
  container(0),
  textsize(1),
  padding(2),
  normal(3),
  height(4);

  final int resSize;
  const Resolution(this.resSize);
}



//normal size
double adjustResolution(BuildContext context, final int resType, final int oriValue){

  int resVal = 0;
  switch(resType){
    case 0:
      //Container
      resVal = 450;
      break;
    case 1:
    case 3:
      //Text box size
      resVal = 400;
      break;
    case 2:
      //Padding
      resVal = 400;
      break;
    case 4:
      resVal = 370;
      break;
  }

  return MediaQuery.of(context).size.width / resVal * oriValue;
}



