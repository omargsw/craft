import 'dart:convert';
import 'dart:developer';

import 'package:craft/components/alert_dialog.dart';
import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/main.dart';
import 'package:craft/model/fetch_bill.dart';
import 'package:craft/model/fetch_request.dart';
import 'package:craft/model/fetch_request_to_customer.dart';
import 'package:craft/view/approve_requests_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  int? userId = sharedPreferences!.getInt('userID');
  int? typeId = sharedPreferences!.getInt('typeID');
  bool isLoading = false;

  List<FetchRequest> requests = [];
  Future fetchRequest() async {
    isLoading = true;
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.getRequests;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchRequest> requestlist =
            fetchRequestFromJson(response.body);
        return requestlist;
      }
    } catch (e) {
      log("[fetchRequest] $e");
    } finally {
      isLoading = false;
    }
  }

  List<FetchRequestsToCustomer> requestsCustomer = [];
  Future fetchRequestsToCustomer() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.getRequestsCustomer +
          "?customer_Id=$userId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchRequestsToCustomer> requestcustomerlist =
            fetchRequestsToCustomerFromJson(response.body);
        return requestcustomerlist;
      }
    } catch (e) {
      log("[fetchRequestsToCustomer] $e");
    } finally {
      isLoading = false;
    }
  }

  List<FetchBills> bills = [];
  Future fetchBills(int requestID) async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.getBills +
          "?customerID=$userId&requestID=$requestID";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchBills> billsList = fetchBillsFromJson(response.body);
        return billsList;
      }
    } catch (e) {
      log("[fetchBills] $e");
    } finally {
      isLoading = false;
    }
  }

  Future cancelRequest(var requestid) async {
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.cancelRequest +
          "?request_id=$requestid";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[cancelRequest] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRequest().then((requestlist) {
      setState(() {
        requests = requestlist;
      });
    });
    fetchRequestsToCustomer().then((requestcustomerlist) {
      setState(() {
        requestsCustomer = requestcustomerlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: (typeId == 1)
            ? (isLoading)
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: requestsCustomer.length,
                    itemBuilder: (context, index) {
                      FetchRequestsToCustomer requestsCustomerApi =
                          requestsCustomer[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 90,
                              width: width * 0.9,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    offset: const Offset(4, 4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                leading: CircleAvatar(
                                    radius: 23,
                                    backgroundImage: NetworkImage(
                                        "https://ogsw.000webhostapp.com/Sanay3i/customerImages/" +
                                            requestsCustomerApi.handyManImage)),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                backgroundColor: Colors.white,
                                                content: SizedBox(
                                                  height: 120,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Are you sure to cancel this request?",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize: 20,
                                                          )),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20),
                                                        child: Text(
                                                            "You will have to pay a fine of 50 JOD",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('NO',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                        )),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      cancelRequest(
                                                          requestsCustomerApi
                                                              .id);
                                                      setState(() {
                                                        fetchRequestsToCustomer()
                                                            .then(
                                                                (requestcustomerlist) {
                                                          setState(() {
                                                            requestsCustomer =
                                                                requestcustomerlist;
                                                          });
                                                        });
                                                      });
                                                      Get.back();
                                                    },
                                                    child: Text('YES',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                        )),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primaryColor)),
                                        child: const Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        print(requestsCustomerApi.id);
                                        await fetchBills(requestsCustomerApi.id)
                                            .then((billsList) {
                                          setState(() {
                                            bills = billsList;
                                          });
                                        });
                                        showModelSheetBill(context);
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primaryColor)),
                                        child: const Center(
                                          child: Text(
                                            "View bill",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name : ${requestsCustomerApi.name}",
                                        style: AppFonts.tajawal16BlackW600),
                                    Text("Phone : ${requestsCustomerApi.phone}",
                                        style: AppFonts.tajawal16BlackW600),
                                    const SizedBox(height: 4),
                                    Text(requestsCustomerApi.status,
                                        style: AppFonts.tajawal14PrimapryW600),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
            : (isLoading)
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      FetchRequest requestApi = requests[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 115,
                              width: width * 0.9,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    offset: const Offset(4, 4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      'https://ogsw.000webhostapp.com/Sanay3i/customerImages/' +
                                          requestApi.customersImage,
                                    )),
                                trailing: TextButton(
                                  onPressed: () {
                                    Get.to(ApproveRequestsPage(
                                      name: requestApi.name,
                                      profileImage:
                                          'https://ogsw.000webhostapp.com/Sanay3i/customerImages/' +
                                              requestApi.customersImage,
                                      phoneNumber: requestApi.phone,
                                      desc: requestApi.descrption,
                                      image: requestApi.image,
                                      lat: requestApi.latitude,
                                      long: requestApi.longitude,
                                      requestid: requestApi.id,
                                    ));
                                  },
                                  child: Text(
                                    'View details',
                                    style: AppFonts.tajawal16PrimapryW600,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.5,
                                      child: Wrap(
                                        children: [
                                          Text(requestApi.name,
                                              style:
                                                  AppFonts.tajawal16BlackW600),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(requestApi.phone,
                                        style: AppFonts.tajawal16BlackW600),
                                    Text(requestApi.status,
                                        style: AppFonts.tajawal14PrimapryW400),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ));
  }

  void showModelSheetBill(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: (bills.isEmpty)
                      ? const Center(
                          child: Text(
                          "No Result",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ))
                      : ListView.builder(
                          itemCount: bills.length,
                          itemBuilder: (context, index) {
                            FetchBills billsApi = bills[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  color: AppColors.secondaryColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      offset: const Offset(4, 4),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Handy man details",
                                        style: AppFonts.tajawal20PrimaryW600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Name : ",
                                          style: AppFonts.tajawal16WhiteW600,
                                        ),
                                        Text(
                                          billsApi.handyManName,
                                          style: AppFonts.tajawal16BlackW600,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Phone number : ",
                                          style: AppFonts.tajawal16WhiteW600,
                                        ),
                                        Text(
                                          billsApi.handyManPhone,
                                          style: AppFonts.tajawal16BlackW600,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 0,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Title",
                                            style: AppFonts.tajawal16WhiteW600,
                                          ),
                                          const SizedBox(
                                            width: 70,
                                          ),
                                          Text(
                                            "Description",
                                            style: AppFonts.tajawal16WhiteW600,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              billsApi.billTitle,
                                              style:
                                                  AppFonts.tajawal16BlackW600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              billsApi.billDescription,
                                              style:
                                                  AppFonts.tajawal16BlackW600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    const Divider(
                                      height: 20,
                                      thickness: 0,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total : ",
                                            style: AppFonts.tajawal16WhiteW600,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                billsApi.price,
                                                style:
                                                    AppFonts.tajawal16BlackW600,
                                              ),
                                              Text(
                                                " JOD",
                                                style: AppFonts
                                                    .tajawal16PrimapryW600,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 0,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
            },
          );
        });
  }
}
