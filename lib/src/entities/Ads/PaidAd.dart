import 'package:woin/src/Base/BaseEntity.dart';
import 'package:woin/src/entities/Ads/Ad.dart';

class PaidAd extends Entity {
  int start;
  int end;
  int adId;
  Ad ad;
  int packetId;
  int transactionId;
  
  PaidAd({int id, this.start, this.end, this.adId = 0, this.packetId = 0, this.transactionId = 0, int createdAt, int updatedAt}) : super(id)
  {
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'start': start,
      'end': end,
      'ad': ad,
      'packetId': packetId,
      'transactionId': transactionId
    };
    map.addAll(super.toJson());
    return map;
  }
}