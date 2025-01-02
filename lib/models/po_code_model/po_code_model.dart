class POCodeMode {
  POCodeMode({this.poCodeEntity});

  factory POCodeMode.fromJson(Map<String, dynamic> json) {
    return POCodeMode(
      poCodeEntity: json['data'] != null
          ? List<POCodeEntity>.from(
              json['data'].map((x) => POCodeEntity.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': poCodeEntity?.map((e) => e.toJson()).toList(),
      };

  List<POCodeEntity>? poCodeEntity;
}

class POCodeEntity {
  POCodeEntity(
      {this.index,
      this.documentCode,
      this.sku,
      this.qty,
      this.qty_actual,
      this.requestType,
      this.uom,
      this.actualReceive,
      this.status,
      this.location});

  factory POCodeEntity.fromJson(Map<String, dynamic> json) {
    return POCodeEntity(
        index: json['index'],
        documentCode: json['documentCode'],
        sku: json['sku'],
        qty: json['qty'],
        qty_actual: json['qty_actual'],
        uom: json['uom'],
        requestType: json['requestType'],
        status: json['status'],
        actualReceive: json['actualReceive'] ?? "",
        location: json['location']);
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'documentCode': documentCode,
      'sku': sku,
      'qty': qty,
      'qty_actual': qty_actual,
      'uom': uom,
      'requestType': requestType,
      'actualReceive': actualReceive,
      'location': location,
      'status': status,
    };
  }

  int? index;
  String? documentCode;
  String? sku;
  int? qty;
  int? qty_actual;
  String? uom;
  String? requestType;
  String? actualReceive;
  String? location;
  String? status;
}
