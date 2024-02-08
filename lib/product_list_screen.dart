import 'package:flutter/material.dart';
import 'package:ostad/add_new_product_screen.dart';
import 'package:ostad/edit_product_screen.dart';

enum PopupMenuType { edit, delete }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
              title: Text("Product Name"),
              subtitle: const Wrap(
                spacing: 16,
                children: [
                  Text("Product code"),
                  Text("Product unit price"),
                  Text("Product total price"),
                  Text("Product quantity"),
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


}
