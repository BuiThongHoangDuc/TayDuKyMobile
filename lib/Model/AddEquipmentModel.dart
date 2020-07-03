class AddEquipmentModel {
  final String eqName, eqDes, eqImage;
  final int eqID, eqQuantity;

  AddEquipmentModel(
      {this.eqDes, this.eqID, this.eqImage, this.eqName, this.eqQuantity});

  Map<String, dynamic> toJson() => {
        "EquipmentId": eqID,
        "EquipmentName": eqName,
        "EquipmentDes": eqDes,
        "EquipmentImage": eqImage,
        "EquipmentQuantity": eqQuantity,
      };

  factory AddEquipmentModel.fromJson(Map<String, dynamic> json) {
    return AddEquipmentModel(
      eqID: json['equipmentId'] as int,
      eqName: json['equipmentName'] as String,
      eqDes: json['equipmentDes'] as String,
      eqImage: json['equipmentImage'] as String,
      eqQuantity: json['equipmentQuantity'] as int,
    );
  }
}
