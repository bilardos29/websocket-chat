import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared/src/convertors/objectid_covertor.dart';
import 'package:shared/src/mongo_entity/base_entity.dart';

part 'mongo_group_entity.g.dart';

///These classes will be same as the dto object
@JsonSerializable(converters: [ObjectIdConvertor()])
class MongoGroupEntity extends BaseEntity {
  
  @JsonKey(name: "groupId")
  final String groupId;
  @JsonKey(name: "groupName")
  final String groupName;
  @JsonKey(name: "totalUser")
  final int totalUser;
  @JsonKey(name: "isGroup")
  final int isGroup;

  MongoGroupEntity({
    required super.id,
    required this.groupId,
    required this.groupName,
    required this.totalUser,
    required this.isGroup
  });

  factory MongoGroupEntity.fromJson(Map<String, dynamic> json) =>
      _$MongoGroupEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MongoGroupEntityToJson(this);
}
