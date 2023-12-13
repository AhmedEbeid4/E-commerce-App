import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/main_screens/explore/widgets/explore_list_widget.dart';
import 'package:e_commerce/view/main_screens/explore/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreView extends StatelessWidget {
  ExploreView({super.key});

  final ProductController _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    _productController.searchText = "";
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            20.he,
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SearchTextField(
                      onTextChanged: (value) {
                        print('VALUE_IN_ON_SAVED : $value');
                        if (value == null) {
                          return;
                        }
                        _productController.searchText = value;
                      },
                    )),
                // FiltersButton(onClick: () {})
              ],
            ),
            20.he,
            Expanded(
              child: GetBuilder<ProductController>(
                id: 'explore',
                builder: (controller) {
                  return FutureBuilder(
                      future: controller.getSearchItems(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          final list = snapshot.data;
                          if (list == null) {
                            return const Center(
                              child: Text(
                                'Something went wrong',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          }
                          if (list.isEmpty) {
                            return const Center(
                              child: Text(
                                'There is no items with this name try to search again',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          }
                          return ExploreListWidget(
                              controller: controller, products: list);
                        }
                        return const SizedBox();
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
