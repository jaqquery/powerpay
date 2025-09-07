//Use for 
// 1. login 
// 2. refreshToken
class Login {
  String? s;
  LoginData? r;
  String? e;

  Login({this.s, this.r, this.e});

  Login.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    r = json['r'] != null ? LoginData.fromJson(json['r']) : null;
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    if (r != null) {
      data['r'] = r!.toJson();
    }
    data['e'] = e;
    return data;
  }
}

class LoginData {
  String? token;
  String? refreshToken;
  int? personTypeID;

  LoginData({this.token, this.refreshToken, this.personTypeID});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    refreshToken = json['RefreshToken'];
    personTypeID = json['PersonTypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['RefreshToken'] = refreshToken;
    data['PersonTypeID'] = personTypeID;
    return data;
  }
}

// Multipurpose usage
// 1. Check Phone Exist
class Responded {
  String? s;
  // ignore: prefer_typing_uninitialized_variables
  var r;
  String? e;

  Responded({this.s, this.r, this.e});

  Responded.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    r = json['r'];
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    data['r'] = r;
    data['e'] = e;
    return data;
  }
}

// list of transactions class
class RespondedList {
  String? s;
  List r = [];
  String? e;

  RespondedList({this.s, required this.r, this.e});

  RespondedList.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    r = json['r'] as List;
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    data['r'] = r;
    data['e'] = e;
    return data;
  }

  RespondedList.clear(){
    s = "";
    r = [];
    e = "";
  }

}


//getSetting class
class Setting {
  String? s;
  R? r;
  String? e;

  Setting({this.s, this.r, this.e});

  Setting.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    r = json['r'] != null ? R.fromJson(json['r']) : null;
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    if (r != null) {
      data['r'] = r!.toJson();
    }
    data['e'] = e;
    return data;
  }
}

class R {
  Person? person;
  Null recentTransactions;
  List<ProductList>? productList;
  int? minDepositAmount;

  R(
      {this.person,
      this.recentTransactions,
      this.productList,
      this.minDepositAmount});

  R.fromJson(Map<String, dynamic> json) {
    person = json['Person'] != null ? Person.fromJson(json['Person']) : null;
    recentTransactions = json['RecentTransactions'];
    if (json['ProductList'] != null) {
      productList = <ProductList>[];
      json['ProductList'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
    minDepositAmount = json['MinDepositAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (person != null) {
      data['Person'] = person!.toJson();
    }
    data['RecentTransactions'] = recentTransactions;
    if (productList != null) {
      data['ProductList'] = productList!.map((v) => v.toJson()).toList();
    }
    data['MinDepositAmount'] = minDepositAmount;
    return data;
  }
}

class Person {
  String? username;
  String? personName;
  double? accountBalance;
  int? notification;
  int? verified;
  int? personTypeID;

  Person(
      {this.username,
      this.personName,
      this.accountBalance,
      this.notification,
      this.verified,
      this.personTypeID});

  Person.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    personName = json['PersonName'];
    accountBalance = json['AccountBalance'];
    notification = json['Notification'];
    verified = json['Verified'];
    personTypeID = json['PersonTypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Username'] = username;
    data['PersonName'] = personName;
    data['AccountBalance'] = accountBalance;
    data['Notification'] = notification;
    data['Verified'] = verified;
    data['PersonTypeID'] = personTypeID;
    return data;
  }
}

class ProductList {
  int? productID;
  int? productCategoryID;
  String? productCategory;
  String? description;
  String? commissionType;
  double? commissionRate;
  int? inventoryBalance;
  int? orderNum;

  ProductList(
      {this.productID,
      this.productCategoryID,
      this.productCategory,
      this.description,
      this.commissionType,
      this.commissionRate,
      this.inventoryBalance,
      this.orderNum});

  ProductList.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    productCategoryID = json['ProductCategoryID'];
    productCategory = json['ProductCategory'];
    description = json['Description'];
    commissionType = json['CommissionType'];
    commissionRate = json['CommissionRate'];
    inventoryBalance = json['InventoryBalance'];
    orderNum = json['OrderNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductID'] = productID;
    data['ProductCategoryID'] = productCategoryID;
    data['ProductCategory'] = productCategory;
    data['Description'] = description;
    data['CommissionType'] = commissionType;
    data['CommissionRate'] = commissionRate;
    data['InventoryBalance'] = inventoryBalance;
    data['OrderNum'] = orderNum;
    return data;
  }
}


//fpx bank class
class Bank {
  String? s;
  BankR? r;
  Null e;

  Bank({this.s, this.r, this.e});

  Bank.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    r = json['r'] != null ? BankR.fromJson(json['r']) : null;
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    if (r != null) {
      data['r'] = r!.toJson();
    }
    data['e'] = e;
    return data;
  }
}

class BankR {
  List<BankInfo>? bankInfo;

  BankR({this.bankInfo});

  BankR.fromJson(Map<String, dynamic> json) {
    if (json['BankInfo'] != null) {
      bankInfo = <BankInfo>[];
      json['BankInfo'].forEach((v) {
        bankInfo!.add(BankInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bankInfo != null) {
      data['BankInfo'] = bankInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankInfo {
  String? name;
  String? code;
  String? imageURL;

  BankInfo({this.name, this.code, this.imageURL});

  BankInfo.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    code = json['Code'];
    imageURL = json['ImageURL'];
  }

  get description => null;

  get bankInfo => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Code'] = code;
    data['ImageURL'] = imageURL;
    return data;
  }
}
