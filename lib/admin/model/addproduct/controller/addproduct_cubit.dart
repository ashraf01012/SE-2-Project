import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'addproduct_state.dart';

class AddproductCubit extends Cubit<AddproductState> {
  AddproductCubit() : super(AddproductInitial());
  final _store = Store();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController qntController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  Future<void> addProductPressed(context) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      _store.addProduct(
        ProductModel(
          pName: nameController.text,
          image: imageController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(qntController.text),
          id: idController.text,
          pCategory: categoryController.text,
          pDescription: descController.text,
        ),
      );
    }
  }
}
