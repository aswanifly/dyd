class AppUrl {
  //google map api
  static const String googleApi =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";
//user
  static const String getUserProfile = "user/getUserProfile";
  static const String editProfile = "user/editUserProfile";
  static const String forGetPassword = "/user/forgotPassword";
  static const String login = "user/signIn";
  static const String signUp = "user/signUp";
  static const String uploadImage = "uploadImage";

  static const String getListOrder = "user/getListOfOrders";
  static const String trackOrder = "user/trackOrder";
  static const String getHotDeals = "user/hotDeals";

  //home
  static const String getAllProducts = "admin/getAllProducts";

  static const String getListOfCategories = "user/getListOfCategories";
  static const String getProductByCategory = "user/getProductsByCategory";
  static const String getProductInfo = "user/getProductInfo";
  static const String getRelatedProducts = "user/getRelatedProducts";

  static const String recentWinners = "user/getRecentWinners";
  static const String availableDraws = "user/getAvailableDraws";
  static const String getProfileCounts = "user/getProfileCount";

//Lucky Card
  static const String getLuckyCards = "user/getUserLotteryTickets";

  //DISCOUNT CARD
  static const String getDiscountCardInfo = "user/getDisscountCardFromAdmin";
  static const String getDiscountcards = "user/getUserDiscountCardList";
  static const String buyDisscountCard = "user/buyDisscountCard";
  static const String checkActiveDiscountCard = "user/checkActiveDiscountCard";

  // address
  static const String addAddress = "user/addAddress";
  static const String getListOfAddresses = "user/getAddress";
  static const String updateAddress = "user/editAddress";
  static const String setAddress = "user/setDefaultAddress";
  static const String deleteAddress = "user/deleteAddress";

  //Cart

  static const String addToCart = "user/addCart";
  static const String getCartItems = "user/getListOfCartItems";
  static const String placeOrder = "user/placeOrder";
  static const String removeCart = "user/RemoveProductFromCart";

  static const String checkCartItem = "user/cartCheck";

//whishlist
  static const String addToWhishList = "user/addToWishlist";
  static const String removeFromWishlist = "user/removeFromWishlist";
  static const String getUserWhitelist = "user/getUserWhitelist";

  //ticket
  static const String getUserLotteryTickets = "user/getUserLotteryTickets";
  static const String getTicketInfo = "user/getTicketInfo";
  static const String buyExtraTicket = "user/purchaseExtraTicket";
}
