import 'dart:developer';

import 'package:admin/api/auth/api_session.dart';
import 'package:admin/models/user/md_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionAccess {
  static SessionAccess instance = SessionAccess();

  Future<void> createSession(AdminModel admin, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', admin.id!);
    prefs.setString('name', '${admin.name}');
    prefs.setString('email', '${admin.email}');
    prefs.setString('role', '${admin.role}');
    prefs.setString('email_verified_at', '${admin.emailVerifiedAt}');
    prefs.setString('created_at', '${admin.createdAt}');
    prefs.setString('updated_at', '${admin.updatedAt}');
    prefs.setString('token', token);
    log('Session created Successfully', name: 'SESSION');
  }

  Future<AdminModel> getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? role = prefs.getString('role');
    String? emailVerifiedAt = prefs.getString('email_verified_at');
    String? createdAt = prefs.getString('created_at');
    String? updatedAt = prefs.getString('updated_at');

    AdminModel admin = AdminModel(
      id: id,
      name: name,
      email: email,
      role: role,
      emailVerifiedAt: emailVerifiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    return admin;
  }

  Future<String?> getSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<bool> isActiveSession() async {
    var storedToken = await getSessionToken();

    if (storedToken == null) {
      return false;
    }

    var session = await SessionApi.auth.session(storedToken);

    if (session == null) {
      return false;
    }

    var isNotActive = session.success == false ||
        session.isActive == null ||
        !session.isActive!;

    if (isNotActive) {
      return false;
    }

    if (session.success == true && session.isActive!) {
      return true;
    }

    return false;
  }

  void destroySession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('role');
    prefs.remove('email_verified_at');
    prefs.remove('created_at');
    prefs.remove('updated_at');
    prefs.remove('token');
  }
}
