import 'package:api_user_repository/api_user_repository.dart';

abstract class BaseRepository {
  final String apiUrl;
  final ApiUserRepo apiUserRepo;

  BaseRepository(this.apiUrl, this.apiUserRepo);




}
