import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class CheckoutState {
  final AddressData? address;
  final String? paymentMethod;
  final String deliveryMethod;

  CheckoutState({
    this.address,
    this.paymentMethod,
    this.deliveryMethod = 'Standard',
  });

  CheckoutState copyWith({
    AddressData? address,
    String? paymentMethod,
    String? deliveryMethod,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
    );
  }
}

class CheckoutNotifier extends Notifier<CheckoutState> {
  @override
  CheckoutState build() {
    return CheckoutState();
  }

  void setAddress(AddressData address) {
    state = state.copyWith(address: address);
  }

  void setPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  void setDeliveryMethod(String method) {
    state = state.copyWith(deliveryMethod: method);
  }

  double getShippingCost() {
    if (state.deliveryMethod == 'Express') return 4.50;
    return 0.0;
  }

  bool isReadyToPay() {
    return state.address != null && state.paymentMethod != null;
  }

  void reset() {
    state = CheckoutState();
  }
}

final checkoutProvider = NotifierProvider<CheckoutNotifier, CheckoutState>(() {
  return CheckoutNotifier();
});
