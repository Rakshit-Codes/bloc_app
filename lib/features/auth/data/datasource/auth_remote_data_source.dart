import 'package:bloc_app/core/failure/exceptions.dart';
import 'package:bloc_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_app/core/constant/app_string.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSesson;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  // TODO: implement currentUserSesson
  Session? get currentUserSesson => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException(AppString.userIsNull);
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException(AppString.userIsNull);
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    // TODO: implement getCurrentUserData
    try {
      if (currentUserSesson != null ) {
              final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSesson!.user.id);
          return UserModel.fromJson(userData.first); 
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
