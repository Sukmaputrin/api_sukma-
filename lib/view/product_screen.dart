import 'package:api_sukma/models/product_model.dart';
import 'package:api_sukma/models/profile_model.dart';
import 'package:api_sukma/services/service.dart';
import 'package:api_sukma/view/form_screen.dart';
import 'package:api_sukma/view/product_form_screen.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Sukma CRUD API",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ProductFormScreen();
                  }),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
          body: SafeArea(
        child: FutureBuilder(
          future: apiService.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error dengan pesan: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Product> products = snapshot.data;
              return _buildListView(products);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Product product = products[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${product.title}",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text("${product.price.toString()}"),
                    Text("${product.description}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Peringatan"),
                                    content: Text(
                                      "Ingin Mengapus ${product.title}?",
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Iya"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService
                                              .deleteProduct(product.id)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Data Berhasil Dihapus")));
                                            } else {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Data Gagal Dihapus")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Tidak"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductFormScreen(
                                        product: product,
                                      )),
                            );
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
