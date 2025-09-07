import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/screens/fpx/bankpage.dart';
import 'package:powerpay/util/assetdata.dart'; 
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/util/serverresponse.dart';

class BankInfoList {
  final String name;
  final String code;
  final String imageUrl;

  BankInfoList({required this.name, required this.code, required this.imageUrl});

  factory BankInfoList.fromJson(Map<String, dynamic> json) {
    return BankInfoList(
      name: json['Name'],
      code: json['Code'],
      imageUrl: json['ImageURL'],
    );
  }
}



class OnlinePayment extends StatefulWidget {
  
  const OnlinePayment({super.key});
  
  @override
  State<OnlinePayment> createState() => _OnlinePayment();
}

class _OnlinePayment extends State<OnlinePayment> {
  String? selectedBankCode;
  List<BankInfoList> bankInfoList = [];

  Future<void> _loadBanks() async {

    var sToken = "";
    sToken = await server.readSecureData(server.token);
    
    const String domain = '$apiPayDomain/PaymentGateway/GetPaymentInfo';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";
   
    var headers = {
      'Authorization': bearerAuthorizationToken
    };
    var request = http.Request('GET', Uri.parse(domain));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var responsestring = await response.stream.bytesToString();
      bank = Bank.fromJson(jsonDecode(responsestring));
      
      if(bank.s == "success"){
        
        Future.delayed(const Duration(milliseconds: 1500), (){
          
          setState(() {
          bankInfoList = (bank.r?.bankInfo ?? [])
            .map((bankInfo) => BankInfoList.fromJson(bankInfo.toJson()))
              .toList();
          });
        });
      }
    }
  }

  Future<String> _payDeposit(final String bankCode, final double amntPayReload) async {
    
    var sToken = await server.readSecureData(server.token);
    const String domain = '$apiPayDomain/PaymentGateway/PayDeposit';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";
   
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': bearerAuthorizationToken
    };
    var request = http.Request('POST', Uri.parse(domain));
    request.body = json.encode({
      "BankCode": bankCode,
      "Amount": amntPayReload
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var responsestring = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));

      if(responseDecoded.s == "success"){
        String urlData = responseDecoded.r['PaymentURL'];
        return urlData;  
      }else{
        // ignore: use_build_context_synchronously
        CustomDialog.cancelDialog(context, responseDecoded.e.toString());
        return "";
      }  
      
    }

    return "";
  }

  Future<void> loadingBanksList() async {
    await Future.wait([
      server.sendRefreshToken(context)
    ]).then((List<bool> value) async {
      _loadBanks();
    });
  }

  @override
  void initState() {
    super.initState();
    loadingBanksList();
  }

  TextEditingController ctrlFpxTextAmount = TextEditingController();
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
            onPopInvoked: ((didPop) {
              if(didPop){
                return;
              }
              Navigator.of(context).pop();
            }),
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Online Payment", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                  centerTitle: true,
                  leading: GestureDetector(
                    child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16),),
                    onTap: () {
                      Navigator.of(context).pop();
                    } ,
                  )
                ),
      
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child:  Container(
                    
                          color: const Color(0xFFF5F5F5),
                          child: 
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child:  Column(children: [
                                    
                                      const SizedBox(height: 20),
                                      Center(child: Image.asset("assets/fpx-gateway-icon.png", width: adjustResolution(context, Resolution.normal.index, 150), height: adjustResolution(context, Resolution.normal.index, 150))),
                                      const SizedBox(height: 20),
                                      bankInfoList.isEmpty
                                        ? const Center(child: CircularProgressIndicator()) // Show loading indicator
                                        : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            
                                            SizedBox(
                                              width: adjustResolution(context, Resolution.normal.index, 300),
                                              child: DropdownButtonFormField<String>(
                                                      style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: Colors.black)),
                                                      value: selectedBankCode,
                                                      items: bankInfoList.map((bank) => 
                                                              DropdownMenuItem<String>(
                                                                value: bank.code,
                                                                child: Row(
                                                                  children: [
                                                                    FadeInImage.assetNetwork(
                                                                      placeholder: 'assets/Empty.png', // Replace with your placeholder image
                                                                      image: bank.imageUrl,
                                                                      width: adjustResolution(context, Resolution.normal.index, 30),
                                                                      height: adjustResolution(context, Resolution.normal.index, 30),
                                                                      
                                                                    ),
                                                                    const SizedBox(width: 10.0),
                                                                    Text(bank.name),
                                                                  ],
                                                                ),
                                                        )).toList(),
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          selectedBankCode = newValue;                                                
                                                        });
                                                      },
                                                      hint: Text('Select Bank', style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16) ))),
                                              ),
                                            ),
                                          ],
                                        ),
                                        
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          SizedBox(
                                            width: adjustResolution(context, Resolution.normal.index, 300),
                                            child: TextField(
                                              style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600)),
                                              textAlign: TextAlign.end,
                                              controller: ctrlFpxTextAmount,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                                                onChanged: (value) {
                                                },
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                border: const OutlineInputBorder(),                                      
                                                labelText: 'Enter Amount',
                                                labelStyle: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600)),
                                                prefix: const Text("RM"),
                                                fillColor: Colors.white,
                                                filled: true
                                                
                                              ),
                                              keyboardType: TextInputType.number, 
                                            ),
                                          )
                                          
                                        ],),
                        
                                        const SizedBox(height: 20),
                                        Center(child: Text("RM1 will be deducted for each transaction.", style:  GoogleFonts.figtree(textStyle:  TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 12), color: Colors.black54, )), textAlign: TextAlign.center,)),
                                        const SizedBox(height: 20),
                                        SizedBox(                        
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 30, right: 30),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),                  
                                            child: Stack(
                                              children: <Widget>[
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    // backgroundColor: const Color(0xFF03033C),
                                                    backgroundColor: buttonColor,
                                                    foregroundColor: Colors.white,
                                                    fixedSize:  Size(
                                                                  adjustResolution(context, Resolution.normal.index, 500),
                                                                  adjustResolution(context, Resolution.normal.index, 50)
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                  ),
                                                  child: Text('Proceed Payment', style: GoogleFonts.figtree(textStyle: const TextStyle( fontSize: 15, fontWeight: FontWeight.w600))),                        
                                                  onPressed: () async {                                            
                                                      
                                                      //check whether bank is selected yet
                                                      if (selectedBankCode == null){
                                                        CustomDialog.okDialog(context, "Please select your bank.");
                                                      }
                                                      else if(ctrlFpxTextAmount.text == ""){
                                                        CustomDialog.okDialog(context, "Kindly enter the balance reload amount.");
                                                      }
                                                      else if(double.parse(ctrlFpxTextAmount.text) < minFpxDepositAmount ){
                                                        CustomDialog.okDialog(context, "Mininum balance reload amount is RM ${minFpxDepositAmount.toStringAsFixed(2)}");
                                                      }
                                                      else {
                                                        await Future.wait([
                                                          _payDeposit(selectedBankCode.toString(), double.parse(ctrlFpxTextAmount.text))
                                                        ]).then((List<String> url) async {
                                                          if(url.isNotEmpty){
                                                          
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BankPage(uri: url[0])));                      
                                                          
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
                                    ],
                            ),
                          ),
                      ),
                    )
                  ],
                ),
        ),
    );
  }
}

