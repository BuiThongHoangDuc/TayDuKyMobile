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
}
