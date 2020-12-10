class AddDeliveryAddressRequest {
    String address_line1;
    String area;
    String full_address;
    String landmark;
    String latitude;
    String longitude;
    String pincode;
    String place_name;
    String place_type;
    int is_delivery_address;

    AddDeliveryAddressRequest({this.address_line1, this.area, this.full_address, this.landmark, this.latitude, this.longitude,
        this.pincode, this.place_name, this.place_type, this.is_delivery_address});

    factory AddDeliveryAddressRequest.fromJson(Map<String, dynamic> json) {
        return AddDeliveryAddressRequest(
            address_line1: json['address_line1'],
            area: json['area'],
            full_address: json['full_address'],
            landmark: json['landmark'],
            latitude: json['latitude'],
            longitude: json['longitude'],
            pincode: json['pincode'],
            place_name: json['place_name'],
            place_type: json['place_type'],
            is_delivery_address: json['is_delivery_address']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address_line1'] = this.address_line1;
        data['area'] = this.area;
        data['full_address'] = this.full_address;
        data['landmark'] = this.landmark;
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        data['pincode'] = this.pincode;
        data['place_name'] = this.place_name;
        data['place_type'] = this.place_type;
        data['is_delivery_address'] = this.is_delivery_address;
        return data;
    }
}