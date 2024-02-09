import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ostad/add_new_product_screen.dart';
import 'package:ostad/edit_product_screen.dart';
import 'package:http/http.dart';
import 'package:ostad/product.dart';

enum PopupMenuType { edit, delete }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductListFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getProductListFromAPI();
        },
        child: Visibility(
          visible: _inProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return _getProductListTile(productList[index]);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewProductScreen()));
        },
        icon: Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }

  // Method Extraction
  Widget _getProductListTile(Product product) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
        NetworkImage(product.image ?? ''),
      ),
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text(
              "Product code: ${product.productCode ?? 'Unknown'}"),
          Text(
              "Unit price: ${product.unitPrice ?? 'Unknown'}"),
          Text(
              "Total price: ${product.totalPrice ?? 'Unknown'}"),
          Text(
              "Quantity: ${product.quantity ?? 'Unknown'}"),
        ],
      ),
      trailing: PopupMenuButton<PopupMenuType>(
          onSelected: (type) =>
              onTapPopupMenuButton(type, product),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: PopupMenuType.edit,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Edit"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: PopupMenuType.delete,
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Delete"),
                ],
              ),
            ),
          ]),
    );
  }

  Future<void> onTapPopupMenuButton(PopupMenuType type, Product product) async {
    switch (type) {
      case PopupMenuType.edit:
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProductScreen(product: product)));
        if (result != null && result == true) {
          getProductListFromAPI();
        }
        break;
      case PopupMenuType.delete:
        _showDeleteDialog(product.id!);
        break;
    }
  }

  void _showDeleteDialog(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Product"),
            content: Text("Are you sure you want to delete product?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    _deleteProduct(productId);
                    Navigator.pop(context);
                  },
                  child:
                      Text("Yes, Delete", style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }

  Future<void> getProductListFromAPI() async {
    _inProgress = true;
    setState(() {});

    /// step 1: make URI
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");

    /// step 2: Call API
    Response response = await get(uri);

    /// step 3: Show response
    if (response.statusCode == 200) {
      productList.clear();
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 'success') {
        var list = decodedResponse['data'];
        for (var item in list) {
          Product product = Product.fromJson(item);
          productList.add(product);
        }
      }
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void> _deleteProduct(String productId) async {
    _inProgress = true;
    setState(() {});

    /// step 1: make URI
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId");

    /// step 2: Call API
    Response response = await get(uri);

    /// step 3: Show response
    if (response.statusCode == 200) {
      //getProductListFromAPI(); // unnecessary api call

      productList.removeWhere((element) => element.id == productId); // front end optimization
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete failed, Try again!")));
    }
    _inProgress = false;
    setState(() {});
  }
}
