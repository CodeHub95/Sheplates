class CardResponse {
  int status;
  String message;
  Data data;

  CardResponse({this.status, this.message, this.data});

  CardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<DcAccToCategory> dcAccToCategory;
  int itemTotalForApp;
  int itemSubTotalForMail;
  num taxes;
  TaxObj taxObj;
  num deliveryCharges;
  num packingCharges;
  num grandTotal;
  List<CartItems> cartItems;

  Data(
      {this.dcAccToCategory,
      this.itemTotalForApp,
      this.itemSubTotalForMail,
      this.taxes,
      this.taxObj,
      this.deliveryCharges,
      this.packingCharges,
      this.grandTotal,
      this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dcAccToCategory'] != null) {
      dcAccToCategory = new List<DcAccToCategory>();
      json['dcAccToCategory'].forEach((v) {
        dcAccToCategory.add(new DcAccToCategory.fromJson(v));
      });
    }
    itemTotalForApp = json['itemTotalForApp'];
    itemSubTotalForMail = json['itemSubTotalForMail'];
    taxes = json['taxes'];
    taxObj = json['taxObj'] != null ? new TaxObj.fromJson(json['taxObj']) : null;
    deliveryCharges = json['deliveryCharges'];
    packingCharges = json['packingCharges'];
    grandTotal = json['grandTotal'];
    if (json['cartItems'] != null) {
      cartItems = new List<CartItems>();
      json['cartItems'].forEach((v) {
        cartItems.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dcAccToCategory != null) {
      data['dcAccToCategory'] = this.dcAccToCategory.map((v) => v.toJson()).toList();
    }
    data['itemTotalForApp'] = this.itemTotalForApp;
    data['itemSubTotalForMail'] = this.itemSubTotalForMail;
    data['taxes'] = this.taxes;
    if (this.taxObj != null) {
      data['taxObj'] = this.taxObj.toJson();
    }
    data['deliveryCharges'] = this.deliveryCharges;
    data['packingCharges'] = this.packingCharges;
    data['grandTotal'] = this.grandTotal;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DcAccToCategory {
  String category;
  int charges;

  DcAccToCategory({this.category, this.charges});

  DcAccToCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    charges = json['charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['charges'] = this.charges;
    return data;
  }
}

class TaxObj {
  num cGST25;
  num sGST25;

  TaxObj({this.cGST25, this.sGST25});

  TaxObj.fromJson(Map<String, dynamic> json) {
    cGST25 = json['CGST@2.5%'];
    sGST25 = json['SGST@2.5%'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CGST@2.5%'] = this.cGST25;
    data['SGST@2.5%'] = this.sGST25;
    return data;
  }
}

class CartItems {
  int kitchenId;
  int quantity;
  String preferredDeliveryTime;
  int id;
  num delieveryCharges;
  num packagingCharges;
  String startDate;
  String endDate;
  num gstAmount;
  num basicSubscriptionPrice;
  String duration;
  String holidays;
  Catalog catalog;
  int days;
  bool stockAvailable;

  CartItems(
      {this.kitchenId,
      this.quantity,
      this.preferredDeliveryTime,
      this.id,
      this.delieveryCharges,
      this.packagingCharges,
      this.startDate,
      this.endDate,
      this.gstAmount,
      this.basicSubscriptionPrice,
      this.duration,
      this.holidays,
      this.catalog,
      this.days,
      this.stockAvailable});

  CartItems.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    quantity = json['quantity'];
    preferredDeliveryTime = json['preferred_delivery_time'];
    id = json['id'];
    delieveryCharges = json['delievery_charges'];
    packagingCharges = json['packaging_charges'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    gstAmount = json['gst_amount'];
    basicSubscriptionPrice = json['basic_subscription_price'];
    duration = json['duration'];
    holidays = json['holidays'];
    catalog = json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
    days = json['days'];
    stockAvailable = json['stockAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchen_id'] = this.kitchenId;
    data['quantity'] = this.quantity;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    data['id'] = this.id;
    data['delievery_charges'] = this.delieveryCharges;
    data['packaging_charges'] = this.packagingCharges;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['gst_amount'] = this.gstAmount;
    data['basic_subscription_price'] = this.basicSubscriptionPrice;
    data['duration'] = this.duration;
    data['holidays'] = this.holidays;
    if (this.catalog != null) {
      data['catalog'] = this.catalog.toJson();
    }
    data['days'] = this.days;
    data['stockAvailable'] = this.stockAvailable;
    return data;
  }
}

class Catalog {
  num price;
  String mealName;
  int id;
  num packagingCharges;
  num deliveryCharges;
  MealCategory mealCategory;

  Catalog({this.price, this.mealName, this.id, this.packagingCharges, this.deliveryCharges, this.mealCategory});

  Catalog.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    mealName = json['meal_name'];
    id = json['id'];
    packagingCharges = json['packaging_charges'];
    deliveryCharges = json['delivery_charges'];
    mealCategory = json['meal_category'] != null ? new MealCategory.fromJson(json['meal_category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['meal_name'] = this.mealName;
    data['id'] = this.id;
    data['packaging_charges'] = this.packagingCharges;
    data['delivery_charges'] = this.deliveryCharges;
    if (this.mealCategory != null) {
      data['meal_category'] = this.mealCategory.toJson();
    }
    return data;
  }
}

class MealCategory {
  String category;
  int id;

  MealCategory({this.category, this.id});

  MealCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['id'] = this.id;
    return data;
  }
}
