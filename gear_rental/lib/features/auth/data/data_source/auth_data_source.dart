import 'dart:io';

import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();
  // Future<List<ProductEntity>> getProducts();

  Future<String> uploadProfilePicture(File file);
}
