class EquipmentBasicModel {
  final String equipmentName, equipmentDes, equipmentImage;
  final int equipmentId, equipmentQuantity;

  EquipmentBasicModel(
      {this.equipmentId,
      this.equipmentName,
      this.equipmentDes,
      this.equipmentImage,
      this.equipmentQuantity});

  factory EquipmentBasicModel.fromJson(Map<String, dynamic> json) {
    return EquipmentBasicModel(
      equipmentId: json['equipmentId'] as int,
      equipmentName: json['equipmentName'] as String,
      equipmentDes: json['equipmentDes'] as String,
      equipmentImage: json['equipmentImage'] as String,
      equipmentQuantity: json['equipmentQuantity'] as int,
    );
  }
}
