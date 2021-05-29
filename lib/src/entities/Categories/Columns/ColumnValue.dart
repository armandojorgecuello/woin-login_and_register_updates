import 'package:woin/src/Base/BaseEntity.dart';

class ColumnValue extends Entity
{
  String content;
  ValueState state;
  int adId;
  int columnId;
  ColumnValue({int id}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'content': content,
      'adId': adId,
      'columnId': columnId
    };
    map.addAll(super.toJson());
    return map;
  }
}

enum ValueState
{
  inactive,
  active
}