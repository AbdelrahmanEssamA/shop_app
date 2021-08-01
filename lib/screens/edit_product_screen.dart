import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  @override
  void initState() {
    _imageUrlController.addListener((_updateImageUrl));
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Product',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          backgroundColor: const Color.fromRGBO(9, 25, 45, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: const Color.fromRGBO(9, 25, 45, 1),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(9, 25, 45, 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                const Color.fromRGBO(9, 25, 45, 1)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_priceFocusNode);
                    },
                  ),
                  TextFormField(
                      cursorColor: const Color.fromRGBO(9, 25, 45, 1),
                      style: TextStyle(
                          color: const Color.fromRGBO(9, 25, 45, 1)),
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          color: const Color.fromRGBO(9, 25, 45, 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  const Color.fromRGBO(9, 25, 45, 1)),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      }),
                  TextFormField(
                    cursorColor: const Color.fromRGBO(9, 25, 45, 1),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: const Color.fromRGBO(9, 25, 45, 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                const Color.fromRGBO(9, 25, 45, 1)),
                      ),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_imageUrlFocusNode);
                    },
                    focusNode: _descriptionFocusNode,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a Url')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor:
                                const Color.fromRGBO(9, 25, 45, 1),
                            decoration: InputDecoration(
                                labelText: 'Image URL',
                                labelStyle: TextStyle(
                                  color: const Color.fromRGBO(
                                      9, 25, 45, 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          9, 25, 45, 1)),
                                )),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
