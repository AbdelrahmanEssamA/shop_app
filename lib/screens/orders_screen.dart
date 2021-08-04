import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart' show Orders;
import '../widgets/orderItem.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Container(
      color: const Color.fromRGBO(21, 40, 75, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Your Orders',
            style: TextStyle(color: Colors.white70, fontSize: 24),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: const Color.fromRGBO(215, 131, 79, 1),
              ))
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 15),
                    height: 200,
                    child: Image.network(
                      'https://cdni.iconscout.com/illustration/premium/thumb/man-holding-shopping-bags-2706058-2257890.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) =>
                          OrderItem(ordersData.orders[i]),
                      itemCount: ordersData.orders.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
