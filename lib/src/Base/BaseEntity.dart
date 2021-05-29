abstract class Entity extends BaseEntity {
  int id;
  Entity(this.id);
  
  Map<String, dynamic> toJson() {
    return {
      'id': 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

abstract class BaseEntity {
  int createdAt = 0;
  int updatedAt = 0;
}