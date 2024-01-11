class AppConst {
  static final AppConst instance = AppConst();

  //Endpoints
  final String getMenu = "/menu/get-menu";
  final String getActiveEvents = "/get-active-events";
  final String logIn = "/auth/log-in";
  final String users = "/users";
  final String deleteAccount = "/delete-account";
  final String setNewUserSettings = "/set-new-user-settings";
  final String userSettings = "/user-settings";
  final String deletePost = "/delete-post";
  final String deleteProfileImage = "/delete-profile-image";
  final String signUp = "/auth/sign-up";
  final String communityShares = "/community/community-shares";
  final String getMoreCommunityShares = "/community/get-more-community-shares";
  final String sharePost = "/community/share-post";
  final String forgotPassword = "/auth/forgot-password";
  final String currentlyInIrish = "/community/currently-in-irish-coffee";
}
