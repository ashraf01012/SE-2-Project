import 'dart:io';
import 'package:auth_module/admin/model/addproduct/controller/addproduct_cubit.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/core/utils/context_extension.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProductPage extends StatelessWidget {
  const NewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddproductCubit(),
      child: BlocBuilder<AddproductCubit, AddproductState>(
        builder: (context, state) {
          final AddproductCubit cubit = context.read<AddproductCubit>();

          return Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              backgroundColor: kSecondryColor,
              title: const Text('Add new product'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: cubit.globalKey,
                  child: Column(
                    children: [
                      ///name
                      TextFormField(
                        decoration: decoration.copyWith(labelText: 'Name'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: cubit.nameController,
                      ),
                      SizedBox(
                        height: context.height / 20,
                      ),

                      ///description
                      TextFormField(
                        decoration:
                            decoration.copyWith(labelText: 'Description'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: cubit.descController,
                      ),
                      SizedBox(
                        height: context.height / 20,
                      ),

                      ///Category
                      TextFormField(
                        decoration: decoration.copyWith(labelText: 'Category'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: cubit.categoryController,
                      ),
                      SizedBox(
                        height: context.height / 20,
                      ),

                      ///quantity
                      TextFormField(
                        decoration:
                            decoration.copyWith(labelText: 'Available count'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: cubit.qntController,
                      ),
                      SizedBox(
                        height: context.height / 20,
                      ),

                      ///Price
                      TextFormField(
                        decoration: decoration.copyWith(labelText: 'Price'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: cubit.priceController,
                      ),
                      SizedBox(
                        height: context.height / 20,
                      ),
                      TextFormField(
                        decoration:
                            decoration.copyWith(labelText: 'image path'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: cubit.imageController,
                      ),
                      SizedBox(
                        height: context.height / 10,
                      ),
                      MaterialButton(
                        onPressed: () => cubit.addProductPressed(context),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        color: Colors.black87,
                        minWidth: double.infinity,
                        height: 50,
                        elevation: 7,
                        child: const Text(
                          "add product",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
