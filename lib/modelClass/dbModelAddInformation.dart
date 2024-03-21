class dbModelAddInformation {
  int? id;
  String? barCodeNo;
  String? productName;
  String? manufacturingPlant;
  String? productDiminsion;
  String? Description;
  String? Review;

  dbModelAddInformation(
      {this.id,
      this.barCodeNo,
      this.productName,
      this.manufacturingPlant,
      this.productDiminsion,
      this.Description,
      this.Review});

  factory dbModelAddInformation.formMap(Map<String, dynamic> map) {
    return dbModelAddInformation(
      id: map['id'],
      barCodeNo: map['barCodeNo'],
      productName: map['productName'],
      manufacturingPlant: map['manufacturingPlant'],
      productDiminsion: map['productDiminsion'],
      Description: map['Description'],
      Review: map['Review'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barCodeNo': barCodeNo,
      'productName': productName,
      'manufacturingPlant': manufacturingPlant,
      'productDiminsion': productDiminsion,
      'Description': Description,
      'Review': Review
    };
  }
}
