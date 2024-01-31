class AppConst {
  static final AppConst instance = AppConst();

  //Endpoints
  final String getMenu = "/menu/get-menu";
  final String getActiveEvents = "/games/get-active-events";
  final String logIn = "/auth/log-in";
  final String userPosts = "/user/user-posts";
  final String userScores = "/user/user-scores";
  final String userFoods = "/user/user-foods";
  final String deleteAccount = "/user/delete-account";
  final String setNewUserSettings = "/user/set-new-user-settings";
  final String userSettings = "/user/user-settings";
  final String deletePost = "/user/delete-post";
  final String deleteProfileImage = "/user/delete-profile-image";
  final String updateProfileImage = "/user/change-profile-photo";
  final String signUp = "/auth/sign-up";
  final String communityShares = "/community/community-shares";
  final String getMoreCommunityShares = "/community/get-more-community-shares";
  final String sharePost = "/community/share-post";
  final String forgotPassword = "/auth/forgot-password";
  final String currentlyInIrish = "/community/currently-in-irish-coffee";
  final String bucketVerification = "/order/verification";
  final String payment = "/order/payment";
  final String createOrder = "/order/create-order";
}
