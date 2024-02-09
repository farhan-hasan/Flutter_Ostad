import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _codeTEC = TextEditingController();
  final TextEditingController _unitPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final TextEditingController _imageTEC = TextEditingController();
  bool _updateProductInProgress = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget.product.productName ?? "";
    _codeTEC.text = widget.product.productCode ?? "";
    _unitPriceTEC.text = widget.product.unitPrice ?? "";
    _quantityTEC.text = widget.product.quantity ?? "";
    _totalPriceTEC.text = widget.product.totalPrice ?? "";
    _imageTEC.text = widget.product.image ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
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
                      visible: _updateProductInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _updateProduct();
                            }
                          },
                          child: Text("Update")),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');
    Product product = Product(
        id: widget.product.id,
        image: _imageTEC.text.trim(),
        productCode: _codeTEC.text.trim(),
        productName: _nameTEC.text.trim(),
        quantity: _quantityTEC.text.trim(),
        totalPrice: _totalPriceTEC.text.trim(),
        unitPrice: _unitPriceTEC.text.trim());
    // Map<String,dynamic> params = {
    //   "Img": _imageTEC.text.trim(),
    //   "ProductCode":_codeTEC.text.trim(),
    //   "ProductName":_nameTEC.text.trim(),
    //   "Qty":_quantityTEC.text.trim(),
    //   "TotalPrice":_totalPriceTEC.text.trim(),
    //   "UnitPrice":_unitPriceTEC.text.trim(),
    //   "_id":widget.product.id,
    // };
    print(product.toJson());
    final Response response = await post(uri,
        body: jsonEncode(product.toJson()),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (decodedData['status'] == 'success') {
        Navigator.pop(context, true);
      } else {
        _updateProductInProgress = true;
        setState(() {});
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Update failed, Try Again!")));
      }
    } else {
      _updateProductInProgress = true;
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update failed, Try Again!")));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageTEC.dispose();
    _totalPriceTEC.dispose();
    _unitPriceTEC.dispose();
    _codeTEC.dispose();
    _nameTEC.dispose();
    _quantityTEC.dispose();
  }
}
