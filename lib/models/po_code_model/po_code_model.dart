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
      this.skuName,
      this.qty,
      this.qtyActual,
      this.requestType,
      this.uom,
      this.actualReceive,
      this.status,
      this.location,
      this.picker,
      this.isActive});

  factory POCodeEntity.fromJson(Map<String, dynamic> json) {
    return POCodeEntity(
        index: json['index'],
        documentCode: json['documentCode'],
        sku: json['sku'],
        skuName: json['skuName'],
        qty: json['qty'],
        qtyActual: json['qty_actual'] ?? 0,
        uom: json['uom'],
        requestType: json['requestType'],
        status: json['status'],
        actualReceive: json['actualReceive'] ?? "",
        location: json['location'],
        picker: json['picker'],
        isActive: json['isActive']);
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'documentCode': documentCode,
      'sku': sku,
      'skuName': skuName,
      'qty': qty,
      'qtyActual': qtyActual,
      'uom': uom,
      'requestType': requestType,
      'actualReceive': actualReceive,
      'location': location,
      'status': status,
      'isActive': isActive,
      'picker': picker,
    };
  }

  int? index;
  String? documentCode;
  String? sku;
  String? skuName;
  int? qty;
  int? qtyActual;
  String? uom;
  String? requestType;
  String? actualReceive;
  String? location;
  String? status;
  String? isActive;
  String? picker;
}
