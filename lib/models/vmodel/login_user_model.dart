class loginModel {
  String? uid = null;
  String? email = null;
  String? password = null;
  String? FullName;
  bool? Gender;
  int? Age;
  String? msg = null;
  loginModel();
  loginModel.loginResponse(this.uid, this.email);
  loginModel.loginRequest(this.email, this.password);
  loginModel.error(this.msg);
}
