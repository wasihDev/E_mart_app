import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/order_screens/component/orderPlaceDetails.dart';
import 'package:emart_app/views/order_screens/component/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> data;
  const OrderDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(color: redColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  orderStatus(
                      title: "Placed",
                      color: redColor,
                      icon: Icons.done,
                      showDone: data['order_placed']),
                  orderStatus(
                      title: "Confirmed",
                      color: Colors.blue,
                      icon: Icons.thumb_up,
                      showDone: data['order_confirmed']),
                  orderStatus(
                      title: "on Delivery",
                      color: Colors.yellow,
                      icon: Icons.car_crash,
                      showDone: data['order_on_delivery']),
                  orderStatus(
                      title: "Delivered",
                      color: Colors.purple,
                      icon: Icons.done_all,
                      showDone: data['order_delivered']),
                ],
              ),
              const Divider(
                thickness: 3,
              ),
              5.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                        title1: "Order Code",
                        title2: "Shipping Method",
                        d1: data["order_code"],
                        d2: data["shipping_method"]),
                    orderPlaceDetails(
                        title1: "Order Date",
                        title2: "Payment_Method",
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format(data["order_date"].toDate()),
                        d2: data["payment_method"]),
                    orderPlaceDetails(
                      title1: "Payment status",
                      title2: "Delivery Status",
                      d1: "Unpaid",
                      d2: "Order Delivered",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shipping Address",
                                style: TextStyle(
                                    color: darkFontGrey, fontFamily: (bold)),
                              ),
                              //Text("${data['order_by_name']}",),
                              Text("${data['order_by_email']}"),
                              Text(
                                "${data['order_by_address']}",
                              ),
                              Text(
                                "${data['order_by_city']}",
                              ),
                              Text("${data['order_by_state']}"),
                              Text("${data['order_by_phone']}"),
                              Text("${data['order_by_postalcode']}"),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                    color: darkFontGrey, fontFamily: (bold)),
                              ),
                              Text(
                                "${data['total_amount']}",
                                style: const TextStyle(
                                    color: redColor, fontFamily: (bold)),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              10.heightBox,
              const Center(
                  child: Text(
                "ordered Product",
                style: TextStyle(
                    color: darkFontGrey, fontFamily: (bold), fontSize: 18),
              )),
              10.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: "${data['orders'][index]['p_name']}",
                            title2: "${data['orders'][index]['t_price']}",
                            d1: "${data['orders'][index]['p_quantity']}x",
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 15,
                            color: Color(
                                int.parse(data['orders'][index]['p_color'])),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                ),
              ),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
