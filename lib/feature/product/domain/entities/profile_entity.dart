import 'package:hive/hive.dart';

part 'profile_entity.g.dart';

@HiveType(typeId: 1)
class ProfileEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullname;
  @HiveField(2)
  String nickname;
  @HiveField(3)
  String email;
  @HiveField(4)
  String dob;
  @HiveField(5)
  String gender;
  @HiveField(6)
  String imageUrl;
  ProfileEntity({
    required this.id,
    required this.fullname,
    required this.nickname,
    required this.email,
    required this.dob,
    required this.gender,
    required this.imageUrl,
  });
}
