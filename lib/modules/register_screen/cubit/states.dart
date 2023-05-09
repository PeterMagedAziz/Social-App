
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  // final LoginModel loginModel;
  //
  // SocialRegisterSuccessState(this.loginModel);
}

class SocialRegisterErrorState extends SocialRegisterStates {
  // final String error;
  //
  // ShopRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates {
  // final LoginModel loginModel;
  //
  // SocialRegisterSuccessState(this.loginModel);
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  // final String error;
  //
  // ShopRegisterErrorState(this.error);
}
class SocialRegisterPasswordVisibilityState extends SocialRegisterStates {}
