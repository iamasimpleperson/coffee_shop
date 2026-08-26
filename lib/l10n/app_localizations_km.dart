// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appName => 'ហាងកាហ្វេ';

  @override
  String get welcome => 'សូមស្វាគមន៍';

  @override
  String get welcomeMessage => 'សូមស្វាគមន៍មកកាន់ហាងកាហ្វេរបស់យើង';

  @override
  String get home => 'ទំព័រដើម';

  @override
  String get menu => 'ម៉ឺនុយ';

  @override
  String get cart => 'កន្ត្រក';

  @override
  String get orders => 'ការកម្មង់';

  @override
  String get profile => 'ប្រវត្តិរូប';

  @override
  String get orderNow => 'កម្មង់ឥឡូវនេះ';

  @override
  String get addToCart => 'បន្ថែមទៅកន្ត្រក';

  @override
  String get language => 'ភាសា';

  @override
  String get chooseLanguage => 'ជ្រើសរើសភាសា';

  @override
  String get english => 'អង់គ្លេស';

  @override
  String get khmer => 'ខ្មែរ';

  @override
  String get popularCoffee => 'កាហ្វេពេញនិយម';

  @override
  String get icedLatte => 'ឡាតេទឹកកក';

  @override
  String get cappuccino => 'កាពូឈីណូ';

  @override
  String get americano => 'អាមេរិកាណូ';

  @override
  String get price => 'តម្លៃ';

  @override
  String get logout => 'ចាកចេញ';

  @override
  String get loginRequired => 'តម្រូវឲ្យចូលគណនី';

  @override
  String get pleaseLogInToAddCart => 'សូមចូលគណនីដើម្បីបន្ថែមទៅកន្ត្រក។';

  @override
  String get pleaseLogInToAddSchedules => 'សូមចូលគណនីដើម្បីបន្ថែមការកំណត់ពេល។';

  @override
  String get pleaseLogInToEditSchedules => 'សូមចូលគណនីដើម្បីកែប្រែការកំណត់ពេល។';

  @override
  String get pleaseLogInToManageSchedules =>
      'សូមចូលគណនីដើម្បីគ្រប់គ្រងការកំណត់ពេល។';

  @override
  String get pleaseLogInToMakeCoffee => 'សូមចូលគណនីដើម្បីឆុងកាហ្វេ។';

  @override
  String get back => 'ត្រឡប់';

  @override
  String get logIn => 'ចូលគណនី';

  @override
  String get signUp => 'ចុះឈ្មោះ';

  @override
  String get subtotal => 'សរុបរង';

  @override
  String get taste => 'រសជាតិ';

  @override
  String get sweetness => 'ភាពផ្អែម';

  @override
  String get noOrdersYet => 'មិនទាន់មានការបញ្ជាទិញទេ';

  @override
  String error(String message) {
    return 'មានបញ្ហា៖ $message';
  }

  @override
  String get noProductsAvailable => 'មិនមានផលិតផលទេ។';

  @override
  String get noCoffeesAvailable => 'មិនមានកាហ្វេទេ។';

  @override
  String addedToCart(int quantity) {
    return 'បានបន្ថែម $quantity ទៅកន្ត្រក!';
  }

  @override
  String get nameAndEmailCannotBeEmpty => 'ឈ្មោះ និងអ៊ីមែលមិនអាចទទេរបានទេ';

  @override
  String get profileUpdatedSuccessfully =>
      'ប្រវត្តិរូបត្រូវបានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ!';

  @override
  String get darkMode => 'មុខងារងងឹត';

  @override
  String get guestMode => 'មុខងារភ្ញៀវ';

  @override
  String get createAccountToOrder =>
      'បង្កើតគណនីដើម្បីកុម្ម៉ង់កាហ្វេ និងរក្សាទុកចំណូលចិត្តរបស់អ្នក។';

  @override
  String pageNotFound(String uri) {
    return 'រកមិនឃើញទំព័រ៖ $uri';
  }

  @override
  String get nameMachine => 'ឈ្មោះម៉ាស៊ីន';

  @override
  String get machineRefilled => 'ម៉ាស៊ីនត្រូវបានបំពេញ!';

  @override
  String get machineCleaned => 'ម៉ាស៊ីនត្រូវបានសម្អាត!';

  @override
  String hello(String name) {
    return 'សួស្តី, $name';
  }

  @override
  String get shortName => 'ឈ្មោះខ្លី';

  @override
  String get time => 'ពេលវេលា';

  @override
  String get schedule => 'ការកំណត់ពេល';

  @override
  String get noSchedulesYet => 'មិនទាន់មានការកំណត់ពេលទេ។ បង្កើតមួយឥឡូវនេះ!';

  @override
  String get repeating => 'ធ្វើឡើងវិញ';

  @override
  String get oneTime => 'តែម្តង';

  @override
  String get favourites => 'ចំណូលចិត្ត';

  @override
  String get noFavoritesYet => 'មិនមានចំណូលចិត្តទេ។ បន្ថែមខ្លះ!';

  @override
  String get yourFavorite => 'ចំណូលចិត្តរបស់អ្នក';

  @override
  String size(String size) {
    return 'ទំហំ $size';
  }

  @override
  String get editSchedule => 'កែប្រែការកំណត់ពេល';

  @override
  String get addSchedule => 'បន្ថែមការកំណត់ពេល';

  @override
  String get saveChanges => 'រក្សាទុកការផ្លាស់ប្តូរ';

  @override
  String get titleLabel => 'ចំណងជើង';

  @override
  String get egMorningCoffee => 'ឧ. កាហ្វេពេលព្រឹក';

  @override
  String get repeatDaily => 'ធ្វើឡើងវិញរៀងរាល់ថ្ងៃ';

  @override
  String get pleaseFillInAllFields => 'សូមបំពេញគ្រប់ចន្លោះ';

  @override
  String get ourCoffee => 'កាហ្វេរបស់យើង';

  @override
  String get details => 'ព័ត៌មានលម្អិត';

  @override
  String get total => 'សរុប';

  @override
  String get checkout => 'គិតប្រាក់';

  @override
  String get yourCartIsEmpty => 'កន្ត្រករបស់អ្នកទទេ';

  @override
  String get paymentSuccessful => 'ការបង់ប្រាក់ជោគជ័យ!';

  @override
  String get orderPlaced => 'បានដាក់ការកម្មង់';

  @override
  String get payNow => 'បង់ឥឡូវនេះ';

  @override
  String get chooseCoffee => 'ជ្រើសរើសកាហ្វេ';

  @override
  String get makeCoffee => 'ឆុងកាហ្វេ';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get customise => 'ប្ដូរតាមបំណង';

  @override
  String get setPerfectTime => 'កំណត់ពេលវេលាដ៏ល្អបំផុតសម្រាប់កាហ្វេរបស់អ្នក។';

  @override
  String get today => 'ថ្ងៃនេះ';

  @override
  String get repeat => 'ធ្វើឡើងវិញ';

  @override
  String get createRoutine => 'បង្កើតទម្លាប់កាហ្វេរបស់អ្នក';

  @override
  String get letMakerHandle => 'ទុកឲ្យម៉ាស៊ីនចាត់ការ។';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get settings => 'ការកំណត់';

  @override
  String get general => 'ទូទៅ';

  @override
  String get reminders => 'ការរំលឹក';

  @override
  String get preferences => 'ចំណូលចិត្ត';

  @override
  String get refillWaterBeans => 'បំពេញទឹក និងគ្រាប់កាហ្វេ';

  @override
  String get cleanMachine => 'សម្អាតម៉ាស៊ីន';

  @override
  String get memberSince => 'សមាជិកតាំងពី: ';

  @override
  String get fullName => 'ឈ្មោះ​ពេញ';

  @override
  String get email => 'អ៊ីមែល';

  @override
  String get nameEmailEmpty => 'ឈ្មោះ និងអ៊ីមែលមិនអាចទទេបានទេ';

  @override
  String get profileUpdated => 'ប្រវត្តិរូបបានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ!';

  @override
  String get guestModeDesc =>
      'បង្កើតគណនីដើម្បីកុម្ម៉ង់កាហ្វេ និងរក្សាទុកចំណូលចិត្តរបស់អ្នក។';

  @override
  String get orderNumber => 'ការបញ្ជាទិញ #';

  @override
  String get enterEmailPassword => 'សូមបញ្ចូលអ៊ីមែលនិងពាក្យសម្ងាត់';

  @override
  String get loginFailed => 'ការចូលគណនីបានបរាជ័យ: ';

  @override
  String get welcomeBack => 'ស្វាគមន៍ត្រឡប់មកវិញ';

  @override
  String get loginAccount => 'ចូលគណនីរបស់អ្នក';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get noAccountSignUp => 'មិនទាន់មានគណនីមែនទេ? ចុះឈ្មោះ';

  @override
  String get continueGuest => 'បន្តក្នុងនាមជាភ្ញៀវ';

  @override
  String get createAccount => 'បង្កើតគណនី';

  @override
  String get signUpToGetStarted => 'ចុះឈ្មោះដើម្បីចាប់ផ្តើម';

  @override
  String get name => 'ឈ្មោះ';

  @override
  String get alreadyAccount => 'មានគណនីរួចហើយ? ចូល';
}
