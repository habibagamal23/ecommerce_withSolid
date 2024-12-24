class ApiConstants {
  static const String apiBaseUrl = "https://dummyjson.com";
  static const String login = "$apiBaseUrl/Urlauth/login";
  static const String categoryList = "$apiBaseUrl/products/category-list";
  static const String user = '$apiBaseUrl/users';
  static const String products  ="$apiBaseUrl/products";
  static const String productsbycategory  ="$apiBaseUrl/products/category";

  static const String urlStripCreatePayment =  "https://api.stripe.com/v1/payment_intents";
  static const String  tokenStripe= "sk_test_51QLO18KCYYcZnriZy6tOCTMspmHTC38AV7zMSfFD73CdQACvjgwNmwIDkFi8SI7D8xDrSfAMmaJlRTwv9PqqIOTI00iZvgjjVX";
}