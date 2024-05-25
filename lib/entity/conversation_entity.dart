import 'package:shecker_partners/entity/message_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'conversation_entity.g.dart';

@JsonSerializable()
class ConversationEntity {
  late String id;
  String? title;
  MessageEntity? latestMessage;
  late String belongUid;
  late int timestamp;
  late String type;

  ConversationEntity();

  factory ConversationEntity.fromJson(Map<String, dynamic> json) => _$ConversationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }


}
