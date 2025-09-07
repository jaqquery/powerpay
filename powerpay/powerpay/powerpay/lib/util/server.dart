// import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:device_uuid/device_uuid.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:powerpay/api/firebase_api.dart';
import 'package:powerpay/screens/logins/login.dart';
import 'package:powerpay/screens/mainscreens/home.dart';
import 'package:powerpay/util/assetdata.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:powerpay/util/date.dart';
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/util/serverresponse.dart';



class Server { 
  final String token = "Token";
  final String refreshToken = "RefreshToken";
  final String userName = "Username";
  final String passWord = "Password";
  final String personName = "PersonName";
  final String acctBal = "AccountBalance";
  final String notiFication = "Notification";
  final String verified = "Verified";
  final String personTypeID = "PersonTypeID";
  final String recentTransactions = "RecentTransactions";
  final String productList = "ProductList"; 

  //ProductList
  final String sDescription  = "Description";              
  final String sProductId    = 'ProductID';
  final String sProductCategoryId = 'ProductCategoryID';
  final String sProductCategory = 'ProductCategory';
  final String sCommissionType = 'CommissionType';
  final String sCommissionRate ='CommissionRate';
  final String sOrderNum = 'OrderNum';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
  Future<void> initNotifications() async{
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

  if (Platform.isIOS) {
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    
    if (apnsToken != null) {
      await FirebaseMessaging.instance.subscribeToTopic("TopicToListen");
    } else {
      await Future<void>.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        await FirebaseMessaging.instance.subscribeToTopic("TopicToListen");
      }
    }
  } else {
    await FirebaseMessaging.instance.subscribeToTopic("TopicToListen");
  }
    await FirebaseApi().initNotifications();
  }

  //Login
  Future<bool> sendLoginRequest(final String user, final String pwd) async {
    
    String? fcmToken = Platform.isAndroid ? 
                        await FirebaseMessaging.instance.getToken() 
                        : await FirebaseMessaging.instance.getAPNSToken();
    
    String uuid = 'Unknown';
    
    await initNotifications();    

    final deviceUuidPlugin = DeviceUuid();
    try {
      uuid = await deviceUuidPlugin.getUUID() ?? 'Unknown uuid version';
    } on PlatformException {
      uuid = 'Failed to get uuid version.';
    }

    const String domain = '$apiDomain/Account/Login';

    try{
      final response = await  http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          "username": user,
          "password": pwd,
          "DeviceID": uuid,          
          "FCMToken": fcmToken.toString()
        }),
      );

      if(response.statusCode == 200){

        Login loginRespond = Login.fromJson(jsonDecode(response.body));
        var status = loginRespond.s.toString();

        if(status == "success"){
  
          //time check
          await setExpiryTimeInMinutes(intDefaultMin);
          
          //credentials          
          await writeSecureData(token, loginRespond.r!.token.toString());
          await writeSecureData(refreshToken, loginRespond.r!.refreshToken.toString());
          await writeSecureData(personTypeID, loginRespond.r!.personTypeID.toString());
          await writeSecureData(userName, user);
          await writeSecureData(passWord, pwd);
          
          return true; 
        }else{
          errLoginMsg = loginRespond.e.toString();
          return false;
        }
      }else{
        //Unable to login
        return false;
      }
    }catch (err){      
      return false;
    }
  }

  Future<bool> sendRefreshToken(BuildContext context) async{

    TokenCheck tokenCheck = TokenCheck();
    if(await tokenCheck.minutesReached(intDefaultMin) == true) {

      var sToken = await readSecureData(token);
      var sRefreshToken = await readSecureData(refreshToken);
      const String domain = '$apiDomain/Account/RefreshLogin';
      final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

      String? fcmToken = await FirebaseMessaging.instance.getToken();
      String uuid = 'Unknown';

      final deviceUuidPlugin = DeviceUuid();
      try {
        uuid = await deviceUuidPlugin.getUUID() ?? 'Unknown uuid version';
      } on PlatformException {
        uuid = 'Failed to get uuid version.';
      }

      try{
        final response = await  http.post(
          Uri.parse(domain),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': bearerAuthorizationToken
          },
          body: jsonEncode(<String, String>{
            "token": sToken.toString(),
            "refreshToken": sRefreshToken.toString(),
            "DeviceID": uuid,          
            "FCMToken": fcmToken.toString()
          }),
        );

        if(response.statusCode == 200){
          
          Login refreshReceived = Login.fromJson(jsonDecode(response.body));

          if(refreshReceived.s == "success"){


            await deleteSecureData(token);
            await deleteSecureData(refreshToken);
          
            await writeSecureData(token, refreshReceived.r!.token.toString());
            await writeSecureData(refreshToken, refreshReceived.r!.refreshToken.toString());
          
            return true;
          }
        }else{
          // ignore: use_build_context_synchronously
          CustomDialog.expiredDialog(context, "Session has expired");
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
          return false; 
        }
       
      }catch (err){   
        // ignore: use_build_context_synchronously
        CustomDialog.expiredDialog(context, "Host unreachable");   
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
        return false;        
      }
    }

    return true;
  }

  //Phone number exist      : true
  //Phone number not exist  : false
  Future<bool>checkPhoneExist(String phNumber) async{  

    bool isExist = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/CheckPhoneExist';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': bearerAuthorizationToken
        },
        body: jsonEncode(<String, String>{
          "phone": phNumber,
        }),
      );

      if(response.statusCode == 200){

        Responded phoneCheckData = Responded.fromJson(jsonDecode(response.body));
        var status = phoneCheckData.s.toString();
        
        switch(status) {
          case "success":
            //Phone number does not exist
            isExist = false;
            break;
          case "error":
          default:
            //Phone number exist
            isExist = true;
            break;
        }
        return isExist;
      }else{
        return false;
      }
    }catch (err){
      return false;   
      // throw Exception(err);
    }
  }

  //Successfully Registered: true
  //Unsuccessfully Registered (phone number/name exist): false
  //PersonTypeID hardcoded to 2 for now
  Future<bool>registerDealer(String phNumber, String name) async{    

    bool isRegistrationSuccess = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/account/Register';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'Application/json',
          'Authorization': bearerAuthorizationToken
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "username" : phNumber,
          "personTypeID" : "2"
        }),
      );

      if(response.statusCode == 200){

        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        var status = responseDecoded.s.toString();

        switch(status) {
          case "success":
            //Phone number successfully registered
            isRegistrationSuccess = true;
            break;
          case "error":
          default:
            //Phone number already exist and registered
            isRegistrationSuccess = false;
            
            break;
        }
        return isRegistrationSuccess;
      }else{
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }
  }

  //Return value:
  //true: successfully logout, therefore return to login page, clear storage in prior
  //false: stay
  Future<bool>sendLogout() async{    

    bool logout = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/Logout';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{        
          'Authorization': bearerAuthorizationToken
        },
      );

      if(response.statusCode == 200){
        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        var status = responseDecoded.s.toString();

        switch(status) {
          case "success":
            logout = true;            
            break;
          case "error":
          default:
            logout = false;
            break;
        }
        return logout;
      }else{
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }
  }

  
  Future<List<dynamic>>changePassword(final String curPwd, final String newPwd, final String confNewPwd) async{
    
    bool isPwdChanged = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/ChangePassword';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': bearerAuthorizationToken
        },
        body: jsonEncode(<String, String>{
          "currentPassword": curPwd,
          "newPassword" : newPwd,
          "confirmNewPassword" : confNewPwd
        }),
      );
      
      
      if(response.statusCode == 200){
        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        var status = responseDecoded.s.toString();
      
        switch(status.toString()) {
          case "success":
            isPwdChanged = true;
            break;
          case "error":
            break;
          default:
            isPwdChanged = false;
            break;
        }

        return [isPwdChanged, responseDecoded.e.toString()];
        
      }else{
        return [false, ""];
      }
    }catch (err){      
      throw Exception(err);
    }
  }

  //True  : Name successfully changed
  //False : Name change failed
  //TESTED: OK
  Future<bool>changeName(final String name) async{
    
    bool isNameChanged = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/ChangeName';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': bearerAuthorizationToken
        },
        body: jsonEncode(<String, String>{
          "name": name,
        }),
      );

      if(response.statusCode == 200){
        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        var status = responseDecoded.s.toString();
      
        switch(status.toString()) {
          case "success":
            isNameChanged = true;
            break;
          case "error":
          default:
            isNameChanged = false;
            break;
        }
        return isNameChanged;
      }else{
        return false;
      }
    }catch (err){      
      return false;
      // throw Exception(err);
    }
  }

  
  Future<bool>updateNotification(bool statToggle) async{
    
    bool setNotificationStatus = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/UpdateNotification';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.post(
        Uri.parse(domain),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': bearerAuthorizationToken
        },
        body: jsonEncode(<String, String>{
          "notification": (statToggle == true)? "1":"0",
        }),
      );

      if(response.statusCode == 200){
        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        var status = responseDecoded.s.toString();
      
        switch(status.toString()) {
          case "success":
            setNotificationStatus = true;   
            await writeSecureData(notiFication, (statToggle == true)? "1":"0");
            break;
          case "error":
          default:
            setNotificationStatus = false;
            break;
        }
        return setNotificationStatus;
      }else{
        return false;
      }
    }catch (err){      
      return false;
      // throw Exception(err);
    }
  }


  //TESTED: OK
  Future<bool> userVerification(String frontIcFile, String backIcFile, String selfieIcFile) async{

    bool verStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/UserVerification';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    var headers = {
      'Authorization': bearerAuthorizationToken
    };

    var request = http.MultipartRequest('POST', Uri.parse(domain));

    try{
      
      final String frontExt = p.extension(frontIcFile).replaceAll('.', '');
      final String backExt = p.extension(backIcFile).replaceAll('.', '');
      final String selfieExt = p.extension(selfieIcFile).replaceAll('.', ''); 

      request.files.add(await http.MultipartFile.fromPath('InputFrontIC', frontIcFile, contentType: MediaType('image', frontExt)));
      request.files.add(await http.MultipartFile.fromPath('InputBackIC', backIcFile, contentType: MediaType('image', backExt)));
      request.files.add(await http.MultipartFile.fromPath('InputSelfieWithIC', selfieIcFile, contentType: MediaType('image', selfieExt)));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();    
      var responsestring = await response.stream.bytesToString();

      if(response.statusCode == 200){

        Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
        lstUsrVerfResponse = [responseDecoded.s.toString(), responseDecoded.r.toString(), responseDecoded.e.toString()];

        if(responseDecoded.s.toString() == "success") {
          verStat = true;
          return true;
        }else{
          verStat = false;
          return false;
        }
        
        

      }
    } catch (err){
      
      if (kDebugMode) {
        print("userverification exception: $err");
      }
      return false;
    }

    return verStat;
    
  }

  //TESTED: OK
  Future<bool>getUserVerificationStatus() async{
    
    bool verStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Account/GetUserVerificationStatus';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.get(
        Uri.parse(domain),
        headers: <String, String>{
          'Authorization': bearerAuthorizationToken
        },
      );

      if(response.statusCode == 200){

        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        lstUsrVerfStat = [responseDecoded.s.toString(), responseDecoded.r.toString(), responseDecoded.e.toString()];
        
        if(responseDecoded.s.toString() == "success") {
          verStat = true;
        }else{
          verStat = false;
        }
       
        return verStat;
      }else{
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }
  }

  //TESTED: OK
  Future<bool>getBalance() async{
    
    bool getBalanceStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Balance/GetBalance';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      final response = await http.get(
        Uri.parse(domain),
        headers: <String, String>{          
          'Authorization': bearerAuthorizationToken
        },
      );

      if(response.statusCode == 200){
        Responded responseDecoded = Responded.fromJson(jsonDecode(response.body));
        switch(responseDecoded.s.toString()) {
          case "success":
            acctbal = responseDecoded.r.toString(); //balance
            getLatestBalance = double.parse(acctbal).toStringAsFixed(2);
            getBalanceStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getBalanceStat = false;
            break;
        }
        
        return getBalanceStat;
      }else{
        return false;
      }
    }catch (err){
      return false;      
      // throw Exception(err);
    }
  }

  Future<bool>getBalanceDetails(final String id) async{
    
    bool getBalanceDetailsStat = false;
    var sToken = await readSecureData(token);
    final String domain = '$apiDomain/Balance/GetBalanceDetail?ID=$id';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();

        Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
        switch(responseDecoded.s.toString()) {
          case "success":
            vBalDetails =  responseDecoded.r; //balance
            getBalanceDetailsStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getBalanceDetailsStat = false;
            break;
        }
        return getBalanceDetailsStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>getBalanceReport(final String dateStart, final String dateEnd) async{
    
    bool getBalanceReportStat = false;
    var sToken = await readSecureData(token);
    String domain = '$apiDomain/Balance/GetBalanceReport?dateStart=$dateStart&dateEnd=$dateEnd';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();

        lstBalReport = RespondedList.fromJson(jsonDecode(responsestring));
        switch(lstBalReport.s.toString()) {
          case "success":
            getBalanceReportStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getBalanceReportStat = false;
            break;
        }

        return getBalanceReportStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }
  
  //Main
  Future<bool>getSetting(BuildContext context) async{

    bool getSettingStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Main/GetSetting';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";
    
    try{
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));      
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send().asStream().first;

      if (response.statusCode == 200) {
        
        var responsestring = await response.stream.bytesToString();

        settings = Setting.fromJson(jsonDecode(responsestring));
        switch(settings.s.toString()) {
          case "success":
            username            = settings.r!.person!.username.toString(); 
            personname          = settings.r!.person!.personName.toString();
            acctbal             = settings.r!.person!.accountBalance.toString();
            notf                = settings.r!.person!.notification.toString();
            verf                = settings.r!.person!.verified.toString();
            ptypeid             = settings.r!.person!.personTypeID.toString();
            prodlist            = settings.r!.productList as List;
            minFpxDepositAmount = double.parse(settings.r!.minDepositAmount.toString());

            //assigning new retrieved values            
            nStat = (notf == "1")? true: false;            
            getLatestBalance = double.parse(acctbal).toStringAsFixed(2);

            telcos            = prodlist.map((product) => product.description).toList();
            productId         = prodlist.map((product) => product.productID).toList();
            productCategoryId = prodlist.map((product) => product.productCategoryID).toList();
            productCategory   = prodlist.map((product) => product.productCategory).toList();
            commissionType    = prodlist.map((product) => product.commissionType).toList();
            commissionRates   = prodlist.map((product) => product.commissionRate).toList();
            orderNum          = prodlist.map((product) => product.orderNum).toList();
            
            getSettingStat = true;                   
            break;
          case "error":
          default:
            getSettingStat = false;
            // ignore: use_build_context_synchronously
            CustomDialog.expiredDialog(context, "Session has expired");      
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
            break;
        }
        return getSettingStat;
      }
      else {
        // ignore: use_build_context_synchronously
        CustomDialog.expiredDialog(context, "Session has expired"); 
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
        return false;
      }
    }catch (err){
      if (kDebugMode) {
        print("GetSetting Exception: $err");
      }      
      // ignore: use_build_context_synchronously
      CustomDialog.expiredDialog(context, "Host unreachable");
      throw Exception(err);
    }    
  }

  Future<bool>getProductDiscount() async{
    
    bool getProdDisStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Main/GetProductDiscount';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));      
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        var responsestring = await response.stream.bytesToString();

        Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
        switch(responseDecoded.s.toString()) {
          case "success":
            getProdDisStat = true;          
            break;
          case "error":
          default:
            getProdDisStat = false;
            break;
        }

        return getProdDisStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>getTransactionHistory(final String startDate, final String endDate) async{
    
    bool getTransHisStat = false;
    var sToken = await readSecureData(token);
    String domain = '$apiDomain/Transaction/GetTransactionHistory?dateStart=$startDate&dateEnd=$endDate';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{      
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();
        lstTrxHistory = RespondedList.fromJson(jsonDecode(responsestring));
        switch(lstTrxHistory.s.toString()) {
          case "success":
            getTransHisStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getTransHisStat = false;
            break;
        }
        return getTransHisStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<List>topupPurchase(final String tProductId, final String amount, final String phoneNo) async{
    
    bool topupPurStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Transaction/TopupPurchase';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('POST', Uri.parse(domain));
      request.body = json.encode({
        "productID": tProductId,
        "amount": amount,
        "phoneNo": "0$phoneNo"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responsestring = await response.stream.bytesToString();

      Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
      if (response.statusCode == 200) {

        switch(responseDecoded.s.toString()) {
          case "success":
            topupPurStat = true;
            break;
          case "error":
          default:
            topupPurStat = false;
            break;
        }
      }
      return [topupPurStat, responseDecoded.s.toString(), responseDecoded.r.toString(), responseDecoded.e.toString()];

    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>getTopupReport(final String dateStart, final String dateEnd) async{
          
    bool getTopupRepStat = false;
    var sToken = await readSecureData(token);
    final String domain = '$apiDomain/Transaction/GetTopupReport?dateStart=$dateStart&dateEnd=$dateEnd';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();

        lstTopupReport = RespondedList.fromJson(jsonDecode(responsestring));
        switch(lstTopupReport.s.toString()) {
          case "success":
            getTopupRepStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getTopupRepStat = false;
            break;
        }
        return getTopupRepStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>getTopupDetail(final String id) async{
    
    bool getTopupDetailStat = false;
    var sToken = await readSecureData(token);
    String domain = '$apiDomain/Transaction/GetTopupDetail?ID=$id';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{      
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      
      if (response.statusCode == 200) {

        var responsestring = await response.stream.bytesToString();   
        Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
        switch(responseDecoded.s.toString()) {
          case "success":
            vTopupDetails = responseDecoded.r;
            getTopupDetailStat = true;          
            break;
          case "error":
          default:
            getTopupDetailStat = false;
            break;
        }

        return getTopupDetailStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }
  }

  Future<bool>getRecentTransaction() async{
    
    bool getRecTransStat = false;
    var sToken = await readSecureData(token);
    const String domain = '$apiDomain/Transaction/GetRecentTransaction';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{      
      var headers = {        
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();
        lstRectrans = RespondedList.fromJson(jsonDecode(responsestring));

        switch(lstRectrans.s.toString()) {
          case "success":
            getRecTransStat = true;          
            break;
          case "error":
          default:
            getRecTransStat = false;
            break;
        }
        return getRecTransStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>getNotifications() async{
    
    List dates = getDateRange(EnumDateRange.thirtyDays.days);

    bool getNtfcStat = false;
    var sToken = await readSecureData(token);
    String domain = '$apiDomain/Main/GetNotifications?dateStart=${dates.first}&dateEnd=${dates.last}';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{      
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('GET', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();

        lstMessages = RespondedList.fromJson(jsonDecode(responsestring));
        switch(lstMessages.s.toString()) {
          case "success":
            getNtfcStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getNtfcStat = false;
            break;
        }

        return getNtfcStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }

  Future<bool>deleteNotifications(final String msgId) async{
    
    bool getDelNtfcStat = false;
    var sToken = await readSecureData(token);
    String domain = '$apiDomain/Main/DeleteNotification/$msgId';
    final String bearerAuthorizationToken = "Bearer ${sToken.toString()}";

    try{      
      var headers = {
        'Authorization': bearerAuthorizationToken
      };
      var request = http.Request('DELETE', Uri.parse(domain));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responsestring = await response.stream.bytesToString();
        
        Responded responseDecoded = Responded.fromJson(jsonDecode(responsestring));
        switch(responseDecoded.s.toString()) {
          case "success":
            getDelNtfcStat = true;          
            break;
          case "error":
          default:
            // Unable to 
            getDelNtfcStat = false;
            break;
        }

        return getDelNtfcStat;
      }
      else {
        return false;
      }
    }catch (err){      
      throw Exception(err);
    }    
  }


  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    String value  = await storage.read(key: key)?? 'No data found';
    return value;
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future<bool> hasKeySecureData(String key) async {
    bool value = await storage.containsKey(key: key);
    return value;
  }

  Future<void> clearData() async {
    await storage.deleteAll();
    prodlist.clear();
    telcos.clear();
    productId.clear();
    productCategoryId.clear();
    productCategory.clear();
    commissionType.clear();
    commissionRates.clear();
    orderNum.clear();
    loginNumberController.clear();
    loginPasswordController.clear();
    amtController.clear();
    prepaidNumberController.clear();    
    vTopupDetails="";
    vBalDetails="";    
    lstUsrVerfStat.clear();
    lstUsrVerfResponse.clear();
    minFpxDepositAmount = 0;

    //object class clearance
    lstRectrans     = RespondedList.clear();
    lstTrxHistory   = RespondedList.clear();
    lstBalReport    = RespondedList.clear();
    lstTopupReport  = RespondedList.clear();
    lstMessages     = RespondedList.clear();
  }
}