import 'package:admin/api/user/api_user.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:get/get.dart';

class UserController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  RxList<UserModel> usersData = <UserModel>[].obs;
  RxList<UserModel> usersRoleUser = <UserModel>[].obs;
  List<UserModel> get usersRoleUserActive =>
      filterUserWithRoleByStatus('Active');

  List<UserModel> filterUserWithRoleByStatus(String status) {
    return usersRoleUser.value
        .where((user) => user.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  void loadAllData() async {
    usersData.value = await userApiData() ?? [];
    usersRoleUser.value = await getApiDataByRole('User') ?? [];
  }
}

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<List<UserModel>?> userApiData() async {
    stateReset();

    //
    isLoading.value = true;
    var response = await ApiUser.fetchAllUser();

    if (response != null) {
      isLoading.value = false;
      isError.value = false;
      return response;
    } else {
      isLoading.value = false;
      isError.value = true;
      return null;
    }
  }

  Future<List<UserModel>?> getApiDataByRole(String role) async {
    stateReset();

    isLoading.value = true;

    var response = await ApiUser.fetchRoleUser(role);

    if (response != null) {
      isLoading.value = false;
      isError.value = false;
      return response;
    } else {
      isLoading.value = false;
      isError.value = true;
      return null;
    }
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
