// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:powerpay/util/assetdata.dart';

enum EnumDateRange { 
  ninetyDays(90),
  thirtyDays(30), 
  sevenDays(7), 
  yesterday(1), 
  today(0);

  final int days;
  const EnumDateRange(this.days);
}

List<String> getDateRange(int range){
    
    var now = DateTime.now();
    String startDate = "", endDate = "";
    
    var formatter = DateFormat('yyyy-MM-dd');
    String todayDate = formatter.format(now);
    String prevDate = formatter.format(DateTime(now.year, now.month, now.day - range));

    if(range == 90 || range == 30 || range == 7){
      startDate = prevDate;
      endDate = todayDate;
    }else if(range == 1){
      startDate = endDate = prevDate;
    }else if(range == 0){
      startDate = endDate = todayDate;
    }
    
    return [startDate, endDate];
}

class TokenCheck {
  Future<bool> minutesReached(int min) async {
    var currentTimeCheck = DateTime.now();
  
    String getExpiryTime = await server.readSecureData(strExpTime);
    expiredTimeCheck = DateTime.parse(getExpiryTime);

    if (kDebugMode) {
      print("TimeCheck: TokenCheck Time");
      print("TimeCheck: TokenCheck currentTime $currentTimeCheck");
      print("TimeCheck: Token Check expiryTime $expiredTimeCheck");
    }

    if(currentTimeCheck.compareTo(expiredTimeCheck) >= 0 ){
      if (kDebugMode) {
        print("TimeCheck: Token Check reached and beyond time");
      }
  
      //update latest time
      await setExpiryTimeInMinutes(min);

      if (kDebugMode) {
        print("TimeCheck: Token Check updated expiry time: $expiredTimeCheck ");
      }
  
      return true;
    }

    if (kDebugMode) {
      print("TimeCheck: Token Check before time");
    }

    return false;
  }

}
   