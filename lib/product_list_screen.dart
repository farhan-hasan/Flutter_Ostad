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
  bool _getProductListInProgress = false;

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
          visible: _getProductListInProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(productList[index].image ?? ''),
                  ),
                  title: Text(productList[index].productName ?? 'Unknown'),
                  subtitle:  Wrap(
                    spacing: 16,
                    children: [
                      Text("Product code: ${productList[index].productCode ?? 'Unknown'}"),
                      Text("Unit price: ${productList[index].unitPrice ?? 'Unknown'}"),
                      Text("Total price: ${productList[index].totalPrice ?? 'Unknown'}"),
                      Text("Quantity: ${productList[index].quantity ?? 'Unknown'}"),
                    ],
                  ),
                  trailing: PopupMenuButton<PopupMenuType>(
                      onSelected: onTapPopupMenuButton,
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


  void onTapPopupMenuButton(PopupMenuType type) {
    switch (type) {
      case PopupMenuType.edit:
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen()));
        break;
      case PopupMenuType.delete:
        _showDeleteDialog();
        break;
    }
  }

  void _showDeleteDialog() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Delete Product"),
        content: Text("Are you sure you want to delete product?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Cancel")),
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Yes, Delete", style: TextStyle(color: Colors.red))),
        ],
      );
    });
  }
  
  Future<void> getProductListFromAPI() async {
    _getProductListInProgress = true;
    setState(() {});
    /// step 1: make URI
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    /// step 2: Call API
    Response response = await get(uri);
    /// step 3: Show response
    print(response);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200) {
      productList.clear();
      var decodedResponse = jsonDecode(response.body);
      if(decodedResponse['status']=='success') {
        var list = decodedResponse['data'];
        for(var item in list) {
          Product product = Product.fromJson(item);
          productList.add(product);
        }
      }
    }
    _getProductListInProgress = false;
    setState(() {});

  }

}
