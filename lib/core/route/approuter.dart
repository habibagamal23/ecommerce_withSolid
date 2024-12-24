import 'package:fibeecomm/core/route/checklogin.dart';
import 'package:fibeecomm/features/cart/cartscreen.dart';
import 'package:fibeecomm/features/home/data/models/product.dart';
import 'package:fibeecomm/features/home/ui/screens/productdetailes.dart';
import 'package:fibeecomm/features/home/ui/widgets/appbar.dart';
import 'package:go_router/go_router.dart';

import '../../features/Login/ui/screens/loginScreen.dart';

import '../../features/categoreis/ui/screen.dart';
import '../../features/home/ui/screens/HomeScreen.dart';
import '../../features/home/ui/widgets/home.dart';
import '../../features/onboarding/onboardingscreen.dart';
import '../../features/payment/Adressnew/newscree.dart';
import '../../features/payment/addscreen.dart';

class ConstantsRoutes {
  static const String splashScreen = "/";
  static const String Mapscreen = "/Mapscreen";
  static const String loginScreen = "/login";
  static const String onBoardingScreen = "/onboard";
  static const String CategoriesPage = "/onboard";
  static const String productPage = "/prod";
  static const String paymentPage = "/paymentPage";
  static const String CategoryProductsScreen = "/CategoryProductsScreen";
  static const String cart = "/cart";
}

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: isloggin
          ? ConstantsRoutes.CategoriesPage
          : ConstantsRoutes.loginScreen,
      routes: [
        // login
        GoRoute(
          path: ConstantsRoutes.loginScreen,
          builder: (context, state) {
            return const Loginscreen();
          },
        ),
        GoRoute(
          path: ConstantsRoutes.paymentPage,
          builder: (context, state) {
            return const PaymentScreenaddnew();
          },
        ),
        GoRoute(
          path: ConstantsRoutes.CategoriesPage,
          builder: (context, state) {
            return const Homescreen();
          },
        ),
        GoRoute(
          path: ConstantsRoutes.productPage,
          builder: (context, state) {
            final prod = state.extra as Product;
            return ProductDetailsScreen(product: prod);
          },
        ),
        GoRoute(
          path: ConstantsRoutes.Mapscreen,
          builder: (context, state) {
            return PaymentScreenadd();
          },
        ),
        GoRoute(
          path: ConstantsRoutes.CategoryProductsScreen,
          builder: (context, state) {
            final prod = state.extra as String;
            return CategoryProductsScreen(categoryName: prod);
          },
        ),
        GoRoute(
          path: ConstantsRoutes.cart,
          builder: (context, state) {
            return CartScreen();
          },
        )
      ]);
}
