import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/dashboard/views/dashboard_view.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import '../controllers/balance_controller.dart';
import 'package:client_mohamoon/tap_loader/awesome_loader.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class BalanceView extends GetView<BalanceController> {
  BalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        isArrowBack: 0,
        text: 'Charge Balance'.tr,
        widget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 40,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Balance'.tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Constants.thirdlyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(
                            () => Text(
                              '${controller.balance.value.toString()} USD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Purchase consulting credits and consult more with our packages'
                              .tr,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 12,
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 17,
                ),
                Text(
                  'Our Packages'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12,
                ),
                TapPayment(
                  text: '25',
                  controller: this.controller,
                ),
                TapPayment(
                  text: '50',
                  controller: this.controller,
                ),
                TapPayment(
                  text: '100',
                  controller: this.controller,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}

class TapPayment extends StatefulWidget {
  final String text;

  final BalanceController controller;

  TapPayment({Key? key, required this.text, required this.controller})
      : super(key: key) {}

  @override
  State<StatefulWidget> createState() =>
      _TapPaymentState(this.text, this.controller);
}

class _TapPaymentState extends State<TapPayment> {
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = "";
  String sdkStatus = "";
  late String sdkErrorCode;
  late String sdkErrorMessage;
  late String sdkErrorDescription;

  // AwesomeLoaderController loaderController = AwesomeLoaderController();
  late Color _buttonColor;
  final String text;
  final BalanceController controller;

  _TapPaymentState(this.text, this.controller) {}

  @override
  void initState() {
    super.initState();
    _buttonColor = Color(0xff2ace00);
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession("25");
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
      bundleId: Platform.isAndroid
          ? "ae.smartlink.client_mohamoon.client_mohamoon"
          : "ae.smartlink.clientmohamoon.clientMohamoon",
      productionSecreteKey: Platform.isAndroid
          ? "sk_live_wAk2Uj9PrtLfmKG1TblMNZFJ"
          : "sk_live_Oa9fiGtYIFD58mTPoelhwEu4",
      sandBoxsecretKey: Platform.isAndroid
          ? "sk_test_8GIkirp3fQTmWuEJy1ZtMx9D"
          : "sk_test_nh1BbHeKPk6pz9YMW2IgDN8c",
      lang: "en",
    );
  }

  //

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession(String amount) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
        trxMode: TransactionMode.PURCHASE,
        transactionCurrency: "USD",
        amount: amount,
        customer: Customer(
            customerId: "",
            // customer id is important to retrieve cards saved for this customer
            email: "test@test.com",
            isdNumber: "965",
            number: "00000000",
            firstName: "test",
            middleName: "test",
            lastName: "test",
            metaData: null),
        paymentItems: <PaymentItem>[],
        // List of taxes
        taxes: [],
        // List of shippnig
        shippings: [],
        postURL: "https://tap.company",
        // Payment description
        paymentDescription: "charge balance",
        // Payment Metadata
        paymentMetaData: {},
        // Payment Reference
        paymentReference: Reference(
            acquirer: "acquirer",
            gateway: "gateway",
            payment: "payment",
            track: "track",
            transaction: "trans_910101",
            order: "appointment_262625"),
        // payment Descriptor
        paymentStatementDescriptor: "paymentStatementDescriptor",
        // Save Card Switch
        isUserAllowedToSaveCard: false,
        // Enable/Disable 3DSecure
        isRequires3DSecure: true,
        // Receipt SMS/Email
        receipt: Receipt(false, false),
        // Authorize Action [Capture - Void]
        authorizeAction:
            AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
        // Destinations
        destinations: null,
        // merchant id
        merchantID: "",
        // Allowed cards
        allowedCadTypes: CardType.ALL,
        applePayMerchantID: "merchant.applePayMerchantID",
        allowsToSaveSameCardMoreThanOnce: false,
        // pass the card holder name to the SDK
        cardHolderName: "Card Holder NAME",
        // disable changing the card holder name by the user
        allowsToEditCardHolderName: true,
        // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
        paymentType: PaymentType.CARD,
        // Transaction mode
        sdkMode: SDKMode.Production,
      );
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }

  /* Future<void> setupSDKSession(String amount) async {
    try {
      print(amount);
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "USD",
          amount: amount,
          customer: Customer(
              customerId: "",
              // customer id is important to retrieve cards saved for this customer
              email: "test@test.com",
              isdNumber: "965",
              number: "00000000",
              firstName: "test",
              middleName: "test",
              lastName: "test",
              metaData: null),
          paymentItems: <PaymentItem>[
            PaymentItem(
                name: "item1",
                amountPerUnit: 1,
                quantity: Quantity(value: 1),
                discount: {
                  "type": "F",
                  "value": 10,
                  "maximum_fee": 10,
                  "minimum_fee": 1,
                },
                description: "Item 1 Apple",
                taxes: [
                  Tax(
                      amount: Amount(
                          type: "F", value: 10, minimumFee: 1, maximumFee: 10),
                      name: "tax1",
                      description: "tax describtion")
                ],
                totalAmount: 100),
          ],
          // List of taxes
          taxes: [
            Tax(
                amount:
                    Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10),
                name: "tax1",
                description: "tax describtion"),
            Tax(
                amount:
                    Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10),
                name: "tax1",
                description: "tax describtion")
          ],
          // List of shippnig
          shippings: [
            Shipping(
                name: "shipping 1",
                amount: 100,
                description: "shiping description 1"),
            Shipping(
                name: "shipping 2",
                amount: 150,
                description: "shiping description 2")
          ],
          postURL: "https://tap.company",
          // Payment description
          paymentDescription: "paymentDescription",
          // Payment Metadata
          paymentMetaData: {
            "a": "a meta",
            "b": "b meta",
          },
          // Payment Reference
          paymentReference: Reference(
              acquirer: "acquirer",
              gateway: "gateway",
              payment: "payment",
              track: "track",
              transaction: "trans_910101",
              order: "order_262625"),
          // payment Descriptor
          paymentStatementDescriptor: "paymentStatementDescriptor",
          // Save Card Switch
          isUserAllowedToSaveCard: true,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(
              type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: "",
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: "merchant.2.lift.style",
          // "merchant.applePayMerchantID",
          allowsToSaveSameCardMoreThanOnce: true,
          // pass the card holder name to the SDK
          cardHolderName: "Card Holder NAME",
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Production);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }*/

  Future<void> startSDK(String amount) async {
    setupSDKSession(amount);
    /* setState(() {
      loaderController.start();
    });*/
    var tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    // loaderController.stopWhenFull();

    setState(() {
      switch (tapSDKResult['sdk_result']) {
        case "SUCCESS":
          sdkStatus = "SUCCESS";
          controller.chargeBalance(tapSDKResult, double.parse(amount));
          _onAlertWithCustomImagePressed(context);
          this.controller.changeBalance(amount);
          this.controller.update();

          break;
        case "FAILED":
          sdkStatus = "FAILED";
          break;
        case "SDK_ERROR":
          sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          sdkErrorMessage = tapSDKResult['sdk_error_message'];
          sdkErrorDescription = tapSDKResult['sdk_error_description'];
          break;

        case "NOT_IMPLEMENTED":
          sdkStatus = "NOT_IMPLEMENTED";
          break;
      }
    });
    setState(() {});
  }

// Alert custom images
  _onAlertWithCustomImagePressed(context) {
    Alert(
      context: context,
      title: "Charge Successfully",
      desc: "You can now book appointments from the \"Book Appointment\" page.",
      image: Image.asset('assets/images/success.png'),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 40,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pay $text USD',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
            ),
          ),
          InkWell(
            onTap: () {
              startSDK(this.text);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Constants.thirdlyColor,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Text(
                'Buy Package'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// 5111 1111 1111 1118
// 01/39  100
