import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  String? _name, _price, _description, _category, _imageLocation;

  @override
  Widget build(BuildContext context) {
    final ProductModel? product =
        ModalRoute.of(context)!.settings.arguments as ProductModel?;

    if (product == null) {
      // Handle the case where product is null
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Product')),
        body: const Center(child: Text('No product data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            TextFormField(
              initialValue: product.pName,
              decoration: const InputDecoration(labelText: 'Name'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
            ),
            SizedBox(height: context.height / 20),
            TextFormField(
              initialValue: product.pDescription,
              decoration: const InputDecoration(labelText: 'Description'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value;
              },
            ),
            SizedBox(height: context.height / 20),
            TextFormField(
              initialValue: product.pCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product category';
                }
                return null;
              },
              onSaved: (value) {
                _category = value;
              },
            ),
            SizedBox(height: context.height / 20),
            TextFormField(
              initialValue: product.price.toString(),
              decoration: const InputDecoration(labelText: 'Price'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) {
                _price = value;
              },
            ),
            SizedBox(height: context.height / 20),
            TextFormField(
              initialValue: product.image,
              decoration: const InputDecoration(labelText: 'Image Path'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the image path';
                }
                return null;
              },
              onSaved: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(height: context.height / 10),
            MaterialButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  final productId = product.id;
                  if (productId != null && productId.isNotEmpty) {
                    print('Product ID: $productId');
                    print('Updated Name: $_name');
                    print('Updated Description: $_description');
                    print('Updated Category: $_category');
                    print('Updated Price: $_price');
                    print('Updated Image Location: $_imageLocation');
                    await _store.editProduct({
                      kProductName: _name,
                      kProductImage: _imageLocation,
                      kProductCategory: _category,
                      kProductDescription: _description,
                      kProductPrice: _price,
                    }, productId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Product updated successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product ID is invalid')),
                    );
                  }
                }
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.black87,
              minWidth: double.infinity,
              height: 50,
              elevation: 7,
              child: const Text(
                'Edit Product',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
