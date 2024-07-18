import 'package:e_shop/controllers/products_controller.dart';
import 'package:e_shop/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName='/route-name';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductsController>(context,listen: false);
    productList.getProducts();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          "e-Shop",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductsController>(
          builder: (context, productsController, child) {
        if (productsController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
              itemCount: productList.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 12,mainAxisSpacing: 12,childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height )), itemBuilder: (BuildContext context,index)=>Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.network(productsController.products[index].images[0],fit: BoxFit.fill,),
                  ),
                  Text(productList.products[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(productList.products[index].description,maxLines: 3,overflow: TextOverflow.ellipsis,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("\$${productList.products[index].price}",style: TextStyle(decoration: TextDecoration.lineThrough),),
                    Text("\$${(productList.products[index].price-productList.products[index].discountPercentage/100).toStringAsFixed(2)}"),
                    Text("${productList.products[index].discountPercentage}% Off",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                  ],)
                ],
                          ),
              ),
            ),)),
        );
      }),
    );
  }
}
