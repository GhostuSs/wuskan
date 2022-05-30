
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 30)
class UserModel extends HiveObject{
  UserModel();
  @HiveField(0)
  int? balance=1000;
  @HiveField(1)
  List<String>? availableSkins=['mike'];
  @HiveField(2)
  String? activeSkin='missqueen';
  @HiveField(3)
  List<String> availableBg=['bg1'];
  @HiveField(4)
  String? activeBg='bg1';
}