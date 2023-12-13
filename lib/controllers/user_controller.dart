import 'package:e_commerce/controllers/data/repository.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/core/toast.dart';
import 'package:e_commerce/model/completed_order.dart';
import 'package:e_commerce/model/order.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/model/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  final Repository repository;

  UserController(this.repository);

  UserModel? user;

  String? pathImage;

  set imagePath(String? path) {
    pathImage = path;
    update(['edit profile pictures']);
  }

  Rx<bool> isUpdatingProfile = false.obs;
  bool isAddingToCart = false;
  bool isBuying = false;

  Future<bool> getUser() async {
    final uid = repository.getUserId();
    if (uid == null) {
      return false;
    }
    bool hasFetched = true;
    final res = await repository.getUser(uid);
    res.fold((l) {
      showToast(l.message);
      hasFetched = false;
    }, (r) {
      user = r;
      user!.id = uid;
    });
    print('USER_ID : ${user!.id}');
    return hasFetched;
  }

  Future updateUser(
      String firstNameText,
      String lastNameText,
      String weightText,
      String heightText,
      String ageText,
      Function(UserModel) onSuccess) async {
    String firstName = firstNameText.trim();
    String lastName = lastNameText.trim();
    String weightString = weightText.trim();
    String heightString = heightText.trim();
    String ageString = ageText.trim();

    if (firstName.isEmpty) {
      showToast('First Name field is Empty');
      return;
    }
    if (lastName.isEmpty) {
      showToast('Last Name field is Empty');
      return;
    }

    if (ageText.isEmpty) {
      showToast('Age Field is empty');
      return;
    }
    if (!ageString.isNumber()) {
      showToast('Enter a valid age, please');
      return;
    }

    if (heightString.isEmpty) {
      showToast('Height Field is empty');
      return;
    }
    if (!heightString.isNumber()) {
      showToast('Enter a valid height, please');
      return;
    }

    if (weightString.isEmpty) {
      showToast('Weight Field is empty');
      return;
    }
    if (!weightString.isNumber()) {
      showToast('Enter a valid weight, please');
      return;
    }

    int age = int.parse(ageString);
    int height = int.parse(heightString);
    int weight = int.parse(weightString);

    if (age > 120 || age <= 5) {
      showToast('Enter a valid age, please');
      return;
    }

    if (height > 210 || height < 110) {
      showToast('Enter a valid height, please');
      return;
    }

    isUpdatingProfile.value = true;
    UserModel updatedUser = UserModel(
        id: user!.id,
        firstName: firstName,
        lastName: lastName,
        email: user!.email,
        age: age,
        height: height,
        weight: weight,
        gender: user!.gender,
        favourites: user!.favourites,
        orders: user!.orders,
        completedOrders: user!.completedOrders,
        imageUrl: user!.imageUrl);

    final res = await repository.updateUser(updatedUser, pathImage);
    res.fold((l) {
      showToast(l.message);
      isUpdatingProfile.value = false;
    }, (updatedUser) {
      showToast('Your Data has been updated successfully');
      onSuccess(updatedUser);
      user = updatedUser;
      update([
        'edit profile pictures',
        'profile username',
        'header profile image'
      ]);
      isUpdatingProfile.value = false;
    });
  }

  Future updateFavourites(Product product) async {
    String id = '${product.id}';
    product.isBeingLiked = true;
    update(['like $id']);

    Set<String> lastLikes = Set<String>.from(user!.favourites!);
    if (lastLikes.contains(id)) {
      lastLikes.remove(id);
    } else {
      lastLikes.add(id);
    }

    final res =
        await repository.updateFavourites(lastLikes.toList(), user!.id!);

    res.fold((l) {
      showToast(l.message);
      product.isBeingLiked = false;
      update(['like $id']);
    }, (r) {
      user!.favourites = r.toSet();
      product.isBeingLiked = false;
      update(['like $id']);
    });
    update(['wishlist']);
  }

  Future addToCart(Product product) async {
    final newOrders = user!.copyOrder();
    newOrders.add(CartOrder(productId: product.id));
    isAddingToCart = true;
    update(['cart button']);
    final res = await repository.updateOrders(newOrders, user!.id!);
    res.fold((l) {
      showToast(l.message);
      isAddingToCart = false;
      update(['cart button']);
    }, (r) {
      user!.addOrder(product.id);
      isAddingToCart = false;
      update(['cart button']);
    });
  }

  Future removeFromCart(Product product) async {
    print('HII');
    final newOrders = user!.removeOrder(product.id);
    isAddingToCart = true;
    update(['cart button', 'cart delete ${product.id}']);
    final res = await repository.updateOrders(newOrders, user!.id!);
    res.fold((l) {
      showToast(l.message);
      isAddingToCart = false;
      update(['cart button', 'cart delete ${product.id}']);
    }, (r) {
      user!.orders = newOrders;
      isAddingToCart = false;
      update(['cart button', 'cart delete ${product.id}']);
    });
  }

  Future removeOrderFromCart(CartOrder cartOrder) async {
    final newOrders = user!.removeOrder(cartOrder.productId!);
    cartOrder.isBeingDeleted = true;
    update(['cart button', 'cart delete ${cartOrder.productId}']);
    final res = await repository.updateOrders(newOrders, user!.id!);
    res.fold((l) {
      showToast(l.message);
      cartOrder.isBeingDeleted = false;
      update(['cart delete ${cartOrder.productId}']);
    }, (r) {
      user!.orders = newOrders;
      update(['cart list', 'total']);
    });
  }

  Future updateQuantity(CartOrder cartOrder, int value) async {
    if (cartOrder.isBeingUpdated) {
      return;
    }
    if (cartOrder.quantity == 1 && value == -1) {
      final newOrders = user!.removeOrder(cartOrder.productId!);
      cartOrder.isBeingUpdated = true;
      update(['cart quantity ${cartOrder.productId}']);
      final res = await repository.updateOrders(newOrders, user!.id!);
      res.fold((l) {
        showToast(l.message);
        cartOrder.isBeingUpdated = false;
        update(['cart quantity ${cartOrder.productId}']);
      }, (r) {
        user!.orders = newOrders;
        update(['cart list', 'total']);
      });
    } else {
      final newQ = cartOrder.quantity + value;
      final newOrders = user!.updateOrder(cartOrder.productId!, newQ);
      cartOrder.isBeingUpdated = true;
      update(['cart quantity ${cartOrder.productId}']);
      final res = await repository.updateOrders(newOrders, user!.id!);
      res.fold((l) {
        showToast(l.message);
        cartOrder.isBeingUpdated = false;
        update(['cart quantity ${cartOrder.productId}']);
      }, (r) {
        cartOrder.isBeingUpdated = false;
        cartOrder.quantity = newQ;
        update([
          'cart quantity ${cartOrder.productId}',
          'cart price ${cartOrder.productId}',
          'total'
        ]);
      });
    }
  }

  Future checkOut2(Product Function(int id) getProduct) async {
    if (user!.orders == null || user!.orders!.isEmpty) {
      showToast('No thing in the cart');
      return;
    }
    final date = getDate();
    final List<CompletedOrder> completedOrder =
        user!.getCompletedOrders(date, getProduct);
    isBuying = true;
    update(['checkout']);
    final res = await repository.checkOut(completedOrder, user!.id!);
    res.fold((l) {
      showToast(l.message);
      isBuying = false;
      update(['checkout']);
    }, (r) {
      showToast('Thank you! Your order has been placed.');
      isBuying = false;
      user!.orders = [];
      user!.completedOrders = completedOrder;
      update(['cart list', 'total', 'checkout']);
    });
  }

  double getTotal(Product? Function(int) getPrice) {
    if (user!.orders == null || user!.orders!.isEmpty) {
      return 0;
    }
    double sum = 0;
    for (var element in user!.orders!) {
      final product = getPrice(element.productId!);
      if (product != null) {
        sum += (element.quantity * product.price);
      }
    }
    return sum;
  }

  bool hasNoOrders() {
    return user!.orders == null || user!.orders!.isEmpty;
  }

  bool hasOrder(Product product) {
    return user!.hasOrdered(product.id);
  }

  bool hasLiked(String id) {
    return user!.favourites!.contains(id);
  }

  List<String> getFavAsList() {
    return user!.getFavAsList();
  }

  void observeData() {
    update(['wishlist', 'show details', 'cart list', 'total']);
  }

  String getDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy/MM/dd').format(now);
  }
}

/*
  Future checkOut() async {
    if (user!.orders == null || user!.orders!.isEmpty) {
      showToast('No thing in the cart');
      return;
    }
    final date = getDate();
    final List<CartOrder> completedOrders = user!.getCompletedOrders(date);
    isBuying = true;
    update(['checkout']);
    final res = await repository.checkOut(completedOrders, user!.id!);
    res.fold((l) {
      showToast(l.message);
      isBuying = false;
      update(['checkout']);
    }, (r) {
      showToast('Thank you! Your order has been placed.');
      isBuying = false;
      user!.orders = [];
      user!.completedOrders = completedOrders;
      update(['cart list', 'total', 'checkout']);
    });
  }

 */
