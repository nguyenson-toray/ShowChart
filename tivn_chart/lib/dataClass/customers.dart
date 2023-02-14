// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';

List<Customers> customersFromJson(String str) =>
    List<Customers>.from(json.decode(str).map((x) => Customers.fromJson(x)));

String customersToJson(List<Customers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customers {
  Customers({
    this.name,
    this.customerDetail,
  });

  String? name;
  CustomerDetail? customerDetail;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        name: json["name"],
        customerDetail: CustomerDetail.fromJson(json["customerDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "customerDetail": customerDetail!.toJson(),
      };
}

class CustomerDetail {
  CustomerDetail({
    this.styles,
    this.colors,
    this.sizes,
  });

  List<String>? styles;
  List<String>? colors;
  List<String>? sizes;

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
        styles: List<String>.from(json["style"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        sizes: List<String>.from(json["sizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "style": List<dynamic>.from(styles!.map((x) => x)),
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "sizes": List<dynamic>.from(sizes!.map((x) => x)),
      };
}


/* json example
{
  "customers": [
    {
      "name": "KASCO",
      "customerDetail": {
        "styles": [
          "styleAA",
          "styleBB"
        ],
        "colors": [
          "RED",
          "BLUE"
        ],
        "sizes": [
          "S",
          "M",
          "L"
        ]
      }
    }
  ]
}
*/