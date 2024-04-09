class dbModelAddInformation {
  int? id;
  String? barCodeNo;
  String? productId;
  String? productName;
  String? manufacturingPlant;
  String? productDiminsion;
  String? productionDescription;
  String? productionReview;
  String? productionCheckUSerId;
  String? qualityCheckRemark;
String? qualityCheckStatus;
String? qualityCheckUserID;
  String? storeRemark;
  String? storeStatus;
  String? storeUserID;


  dbModelAddInformation(
      {this.id,
      this.barCodeNo,
      this.productId,
      this.productName,
      this.manufacturingPlant,
      this.productDiminsion,
      this.productionDescription,
      this.productionReview,
      this.productionCheckUSerId,
            this.qualityCheckRemark,
      this.qualityCheckStatus,
      this.qualityCheckUserID,
      this.storeRemark,
      this.storeStatus,
      this.storeUserID,

});

  factory dbModelAddInformation.formMap(Map<String, dynamic> map) {
    return dbModelAddInformation(
      id: map['id'],
      barCodeNo: map['barCodeNo'],
            productId: map['productId'],
        productName: map['productName'],
      manufacturingPlant: map['manufacturingPlant'],
      productDiminsion: map['productDiminsion'],
      productionDescription: map['productionDescription'],
      productionReview: map['productionReview'],
            productionCheckUSerId: map['productionCheckUSerId'],

         qualityCheckRemark: map['qualityCheckRemark'],
            qualityCheckStatus: map['qualityCheckStatus'],
               qualityCheckUserID: map['qualityCheckUserID'],
                  storeRemark: map['storeRemark'],
                     storeStatus: map['storeStatus'],
                        storeUserID: map['storeUserID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barCodeNo': barCodeNo,
      'productId':productId,
      'productName': productName,
      'manufacturingPlant': manufacturingPlant,
      'productDiminsion': productDiminsion,
      'productionDescription': productionDescription,
      'productionReview': productionReview,
      'productionCheckUSerId':productionCheckUSerId,
            'qualityCheckRemark': qualityCheckRemark,
      'qualityCheckStatus': qualityCheckStatus,
      'qualityCheckUserID': qualityCheckUserID,
      'storeRemark': storeRemark,
      'storeStatus': storeStatus,
      'storeUserID': storeUserID,
      

    };
  }
}
