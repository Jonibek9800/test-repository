

import 'check_details.dart';

class Check {
  int? id;
  int? userId;
  int? totalQuantity;
  int? totalCost;
  String? orderStatus;
  List<CheckDetails>? details;
  String? createdAt;
  String? updatedAt;

  Check({
    required this.id,
    required this.userId,
    required this.totalCost,
    required this.totalQuantity,
    required this.details,
    required this.createdAt,
    required this.orderStatus,
    required this.updatedAt,
  });

  Check.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalCost = json['total_cost'];
    totalQuantity = json['total_quantity'];
    details =
        (json['details'] as List<dynamic>).map((e) => CheckDetails.fromJson(e)).toList();
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_cost'] = totalCost;
    data['total_quantity'] = totalQuantity;
    data['order_status'] = orderStatus;
    data['details'] = details?.map((e) => e.toJson());
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
