import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'choose_coffee.dart';
import '../../home/models/favorites_manager.dart';
import 'package:coffee_shop/routes/auth_notifier.dart';
import 'package:coffee_shop/features/machine/models/machine_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';

class CoffeeDetail extends ConsumerStatefulWidget {
  final CoffeeOption coffee;

  const CoffeeDetail({super.key, required this.coffee});

  @override
  ConsumerState<CoffeeDetail> createState() => _CoffeeDetailState();
}

class _CoffeeDetailState extends ConsumerState<CoffeeDetail> {
  String selectedSize = '';
  String selectedFlavor = '';
  int amount = 1;
  bool isFavourite = false;
  String selectedTime = ''; // Time to make

  @override
  void initState() {
    super.initState();
  }

  bool isBrewing = false;
  bool isDone = false;
  int brewingTimeLeft = 10;
  Timer? _brewingTimer;

  void startBrewing() {
    if (!ref.read(authProvider).isAuthenticated) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.loginRequired ?? 'Login Required'),
          content: Text(AppLocalizations.of(context)?.pleaseLogInToMakeCoffee ?? 'Please log in to make coffee.'),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(AppLocalizations.of(context)?.back ?? 'Back'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
                context.push('/login');
              },
              child: Text(AppLocalizations.of(context)?.logIn ?? 'Log In'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      isBrewing = true;
      isDone = false;
      brewingTimeLeft = 10;
    });
    _brewingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (brewingTimeLeft > 0) {
        setState(() {
          brewingTimeLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          isDone = true;
        });
        ref.read(machineProvider.notifier).makeCoffee();
      }
    });
  }

  void stopBrewing() {
    _brewingTimer?.cancel();
    setState(() {
      isBrewing = false;
      isDone = false;
    });
  }

  @override
  void dispose() {
    _brewingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFavourite = ref.watch(favoritesProvider).any((fav) => fav.id == widget.coffee.id);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: isBrewing
          ? (isDone ? _buildDoneState() : _buildBrewingState())
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back/close and favourite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.black87,
                        ),
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      widget.coffee.name.replaceAll('\n', ' '),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (!ref.read(authProvider).isAuthenticated) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)?.loginRequired ?? 'Login Required'),
                              content: Text(AppLocalizations.of(context)?.loginRequired ?? 'Please log in to add favourites.'),
                              actions: [
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: Text(AppLocalizations.of(context)?.back ?? 'Back'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.pop();
                                    context.push('/login');
                                  },
                                  child: Text(AppLocalizations.of(context)?.logIn ?? 'Log In'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        setState(() {
                          final favoriteOption = CoffeeOption(
                            id: widget.coffee.id,
                            name: widget.coffee.name,
                            icon: widget.coffee.icon,
                            size: selectedSize.isNotEmpty ? selectedSize : 'Small',
                            flavor: selectedFlavor.isNotEmpty ? selectedFlavor : 'Regular',
                          );
                          ref.read(favoritesProvider.notifier).toggleFavorite(favoriteOption);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Size Selection
                Text(
                  AppLocalizations.of(context)?.size('').trim() ?? 'Size',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: ['Small', 'Medium', 'Large'].map((size) {
                    final isSelected = selectedSize == size;
                    IconData icon = Icons.coffee;
                    String volume = '';
                    double iconSize = 24.0;

                    if (size == 'Small') {
                      icon = Icons.coffee;
                      volume = '150ml';
                      iconSize = 20.0;
                    } else if (size == 'Medium') {
                      icon = Icons.local_cafe;
                      volume = '250ml';
                      iconSize = 24.0;
                    } else {
                      icon = Icons.local_cafe;
                      volume = '400ml';
                      iconSize = 28.0;
                    }

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedSize = size),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  icon,
                                  color: isSelected
                                      ? const Color.fromARGB(221, 0, 0, 0)
                                      : Colors.grey.shade400,
                                  size: iconSize,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  size,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black87
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  volume,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black38
                                        : Colors.grey.shade400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Flavor Selection
                Text(
                  AppLocalizations.of(context)?.taste ?? 'Flavor',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: ['Light', 'Regular', 'Strong'].map((flavor) {
                    final isSelected = selectedFlavor == flavor;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedFlavor = flavor),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: Center(
                                    child: _buildFlavorIcon(
                                      flavor,
                                      isSelected
                                          ? Colors.black87
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  flavor,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black87
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Amount and Add to cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Amount
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20),
                            onPressed: () {
                              if (amount > 1) {
                                setState(() => amount--);
                              }
                            },
                          ),
                          Text(
                            amount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20),
                            onPressed: () {
                              setState(() => amount++);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Add to cart button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            startBrewing();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)?.makeCoffee ?? 'Make it!',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }

  Widget _buildDoneState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF67C4A7), width: 3),
          ),
          child: const Center(
            child: Icon(Icons.coffee, size: 32, color: Colors.black),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Enjoy your coffee',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Don\'t forget to put a cup\nfor the next brew.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBrewingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_t57a1773.json',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return CircularProgressIndicator(
                    value: brewingTimeLeft / 10,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                  );
                },
              ),
              Center(
                child: Text(
                  '${brewingTimeLeft}s',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Brewing..',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Feel free to close this screen,\nyour coffee will be ready soon.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              stopBrewing();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black87,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Stop',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBean(Color color, {double angle = -0.5}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 8,
        height: 14,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildFlavorIcon(String flavor, Color color) {
    if (flavor == 'Light') {
      return _buildBean(color);
    } else if (flavor == 'Regular') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBean(color, angle: -0.3),
          _buildBean(color, angle: 0.3),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBean(color, angle: -0.5),
          _buildBean(color, angle: 0),
          _buildBean(color, angle: 0.5),
        ],
      );
    }
  }
}
