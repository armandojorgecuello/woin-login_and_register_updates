import 'package:woin/src/Base/BaseEntity.dart';
import 'package:woin/src/entities/Ads/PaidAd.dart';

class PayForView extends Entity {
  double initialAmount;
  double currentAmount;
  double personAmount;
  int viewDuration;
  int viewGift;
  PaidAd paidAd;

  PayForView({int id, this.initialAmount, this.personAmount, this.viewDuration, this.viewGift, this.paidAd, int createdAt, int updatedAt}) : super(id)
  {
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'initialAmount': initialAmount,
      'currentAmount': currentAmount,
      'personAmount': personAmount,
      'viewDuration': viewDuration,
      'viewGift': viewGift,
      'paidAd': paidAd
    };
    map.addAll(super.toJson());
    return map;
  }
}