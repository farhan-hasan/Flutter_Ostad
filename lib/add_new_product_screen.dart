import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _codeTEC = TextEditingController();
  final TextEditingController _unitPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final TextEditingController _imageTEC = TextEditingController();
  bool _addNewProductInProgress = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEC,
                  decoration: const InputDecoration(
                      hintText: "Product name",
                      labelText: "Enter Product name"),
                  // TODO: make this validation reusable
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _codeTEC,
                  decoration: const InputDecoration(
                      hintText: "Product code",
                      labelText: "Enter Product code"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Code";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _unitPriceTEC,
                  decoration: const InputDecoration(
                      hintText: "Unit price", labelText: "Enter Unit price"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Unit Price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _totalPriceTEC,
                  decoration: const InputDecoration(
                      hintText: "Total price", labelText: "Enter Total price"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Total Price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _imageTEC,
                  decoration: const InputDecoration(
                      hintText: "Image", labelText: "Enter Image URL"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Image";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _quantityTEC,
                  decoration: const InputDecoration(
                      hintText: "Quantity", labelText: "Enter Quantity"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Quantity";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _addNewProductInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              createNewProduct();
                            }
                          },
                          child: Text("Add")),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createNewProduct() async {
    _addNewProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> params = {
      "ProductName": _nameTEC.text.trim(),
      "ProductCode": _codeTEC.text.trim(),
      "Img": _imageTEC.text.trim(),
      "UnitPrice": _unitPriceTEC.text.trim(),
      "Qty": _quantityTEC.text.trim(),
      "TotalPrice": _totalPriceTEC.text.trim(),
    };
    Response response = await post(uri,
        body: jsonEncode(params),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      _nameTEC.clear();
      _codeTEC.clear();
      _imageTEC.clear();
      _unitPriceTEC.clear();
      _quantityTEC.clear();
      _totalPriceTEC.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product added successfully")));
    }
    _addNewProductInProgress = false;
    setState(() {});

    @override
    void dispose() {
      _nameTEC.dispose();
      _totalPriceTEC.dispose();
      _unitPriceTEC.dispose();
      _quantityTEC.dispose();
      _codeTEC.dispose();
      _imageTEC.dispose();
      super.dispose();
    }
  }
}
