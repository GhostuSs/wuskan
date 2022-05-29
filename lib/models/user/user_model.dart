
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 30)
class UserModel extends HiveObject{
  UserModel();
  @HiveField(0)
  int? balance;
  @HiveField(1)
  List<String>? availableSkins=[];
  @HiveField(2)
  String? activeSkin;
  @HiveField(3)
  List<String> availableBg=[];
  @HiveField(4)
  String? activeBg;
}