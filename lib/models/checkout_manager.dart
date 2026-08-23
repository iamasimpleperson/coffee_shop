import 'package:flutter/foundation.dart';

class AddressData {
  final String firstName;
  final String surname;
  final String postCode;
  final String address;
  final String county;
  final String city;

  AddressData({
    required this.firstName,
    required this.surname,
    required this.postCode,
    required this.address,
    required this.county,
    required this.city,
  });

  String get displayAddress => '$address, $city, $postCode';
}

class CheckoutManager {
  static final ValueNotifier<AddressData?> addressNotifier =
      ValueNotifier<AddressData?>(null);
  static final ValueNotifier<String?> paymentMethodNotifier =
      ValueNotifier<String?>(null);
  static final ValueNotifier<String> deliveryMethodNotifier =
      ValueNotifier<String>('Standard');

  static void setAddress(AddressData address) {
    addressNotifier.value = address;
  }

  static void setPaymentMethod(String method) {
    paymentMethodNotifier.value = method;
  }

  static void setDeliveryMethod(String method) {
    deliveryMethodNotifier.value = method;
  }

  static double getShippingCost() {
    if (deliveryMethodNotifier.value == 'Express') return 4.50;
    return 0.0;
  }

  static bool isReadyToPay() {
    return addressNotifier.value != null && paymentMethodNotifier.value != null;
  }

  static void reset() {
    addressNotifier.value = null;
    paymentMethodNotifier.value = null;
    deliveryMethodNotifier.value = 'Standard';
  }
}
