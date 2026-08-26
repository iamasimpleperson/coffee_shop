// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Coffee Shop';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeMessage => 'Welcome to our coffee shop';

  @override
  String get home => 'Home';

  @override
  String get menu => 'Menu';

  @override
  String get cart => 'Cart';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get orderNow => 'Order Now';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get english => 'English';

  @override
  String get khmer => 'Khmer';

  @override
  String get popularCoffee => 'Popular Coffee';

  @override
  String get icedLatte => 'Iced Latte';

  @override
  String get cappuccino => 'Cappuccino';

  @override
  String get americano => 'Americano';

  @override
  String get price => 'Price';

  @override
  String get logout => 'Logout';

  @override
  String get loginRequired => 'Login Required';

  @override
  String get pleaseLogInToAddCart => 'Please log in to add to cart.';

  @override
  String get pleaseLogInToAddSchedules => 'Please log in to add schedules.';

  @override
  String get pleaseLogInToEditSchedules => 'Please log in to edit schedules.';

  @override
  String get pleaseLogInToManageSchedules =>
      'Please log in to manage schedules.';

  @override
  String get pleaseLogInToMakeCoffee => 'Please log in to make coffee.';

  @override
  String get back => 'Back';

  @override
  String get logIn => 'Log In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get taste => 'Taste';

  @override
  String get sweetness => 'Sweetness';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get noProductsAvailable => 'No products available.';

  @override
  String get noCoffeesAvailable => 'No coffees available.';

  @override
  String addedToCart(int quantity) {
    return 'Added $quantity item(s) to cart!';
  }

  @override
  String get nameAndEmailCannotBeEmpty => 'Name and Email cannot be empty';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully!';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get guestMode => 'Guest Mode';

  @override
  String get createAccountToOrder =>
      'Create an account to order coffee and save your preferences.';

  @override
  String pageNotFound(String uri) {
    return 'Page not found: $uri';
  }

  @override
  String get nameMachine => 'Name Machine';

  @override
  String get machineRefilled => 'Machine refilled!';

  @override
  String get machineCleaned => 'Machine cleaned!';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get shortName => 'Short name';

  @override
  String get time => 'Time';

  @override
  String get schedule => 'Schedule';

  @override
  String get noSchedulesYet => 'No schedules yet. Create one!';

  @override
  String get repeating => 'Repeating';

  @override
  String get oneTime => 'One-time';

  @override
  String get favourites => 'Favourites';

  @override
  String get noFavoritesYet => 'No favorites yet. Add some!';

  @override
  String get yourFavorite => 'Your favorite';

  @override
  String size(String size) {
    return 'Size $size';
  }

  @override
  String get editSchedule => 'Edit Schedule';

  @override
  String get addSchedule => 'Add Schedule';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get titleLabel => 'Title';

  @override
  String get egMorningCoffee => 'e.g., Morning Coffee';

  @override
  String get repeatDaily => 'Repeat Daily';

  @override
  String get pleaseFillInAllFields => 'Please fill in all fields';

  @override
  String get ourCoffee => 'Our Coffee';

  @override
  String get details => 'Details';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get yourCartIsEmpty => 'Your cart is empty';

  @override
  String get paymentSuccessful => 'Payment Successful!';

  @override
  String get orderPlaced => 'Order Placed';

  @override
  String get payNow => 'Pay Now';

  @override
  String get chooseCoffee => 'Choose Coffee';

  @override
  String get makeCoffee => 'Make Coffee';

  @override
  String get cancel => 'Cancel';

  @override
  String get customise => 'Customise';

  @override
  String get setPerfectTime => 'Set the perfect time for your coffee.';

  @override
  String get today => 'Today';

  @override
  String get repeat => 'Repeat';

  @override
  String get createRoutine => 'Create your coffee routine';

  @override
  String get letMakerHandle => 'Let the maker handle the rest.';

  @override
  String get save => 'Save';

  @override
  String get settings => 'Settings';

  @override
  String get general => 'General';

  @override
  String get reminders => 'Reminders';

  @override
  String get preferences => 'Preferences';

  @override
  String get refillWaterBeans => 'Refill Water & Beans';

  @override
  String get cleanMachine => 'Clean Machine';

  @override
  String get memberSince => 'Member since: ';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get nameEmailEmpty => 'Name and Email cannot be empty';

  @override
  String get profileUpdated => 'Profile updated successfully!';

  @override
  String get guestModeDesc =>
      'Create an account to order coffee and save your preferences.';

  @override
  String get orderNumber => 'Order #';

  @override
  String get enterEmailPassword => 'Please enter email and password';

  @override
  String get loginFailed => 'Login failed: ';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginAccount => 'Log in to your account';

  @override
  String get password => 'Password';

  @override
  String get noAccountSignUp => 'Don\'t have an account? Sign Up';

  @override
  String get continueGuest => 'Continue as Guest';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signUpToGetStarted => 'Sign up to get started';

  @override
  String get name => 'Name';

  @override
  String get alreadyAccount => 'Already have an account? Log In';
}
