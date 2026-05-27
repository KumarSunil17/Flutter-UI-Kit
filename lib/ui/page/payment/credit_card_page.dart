import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/credit_card_bloc.dart';
import 'package:flutter_uikit/ui/widgets/profile_tile.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  late final CreditCardBloc cardBloc;
  late final TextEditingController ccController;
  late final TextEditingController expController;
  late final MaskTextInputFormatter ccMaskFormatter;
  late final MaskTextInputFormatter expMaskFormatter;

  @override
  void initState() {
    super.initState();
    cardBloc = CreditCardBloc();
    ccMaskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {'#': RegExp(r'[0-9]')},
    );
    expMaskFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {'#': RegExp(r'[0-9]')},
    );
    ccController = TextEditingController();
    expController = TextEditingController();
  }

  @override
  void dispose() {
    cardBloc.dispose();
    ccController.dispose();
    expController.dispose();
    super.dispose();
  }

  String _displayText(String? value, String fallback) {
    if (value == null || value.isEmpty) {
      return fallback;
    }
    return value;
  }

  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[creditCardWidget(), fillEntries()],
        ),
      );

  Widget creditCardWidget() {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: UIData.kitGradients)),
              ),
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/images/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              const Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  stream: cardBloc.nameOutputStream,
                  initialData: "Your Name",
                  builder: (context, snapshot) => Text(
                        _displayText(snapshot.data, "Your Name"),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: UIData.ralewayFont,
                            fontSize: 20.0),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                stream: cardBloc.ccOutputStream,
                initialData: "**** **** **** ****",
                builder: (context, snapshot) => Text(
                      _displayText(snapshot.data, "**** **** **** ****"),
                      style: const TextStyle(color: Colors.white, fontSize: 22.0),
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: cardBloc.expOutputStream,
                    initialData: "MM/YY",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.white,
                          title: "Expiry",
                          subtitle: _displayText(snapshot.data, "MM/YY"),
                        )),
                const SizedBox(
                  width: 30.0,
                ),
                StreamBuilder<String>(
                    stream: cardBloc.cvvOutputStream,
                    initialData: "***",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.white,
                          title: "CVV",
                          subtitle: _displayText(snapshot.data, "***"),
                        )),
              ],
            ),
          ],
        ),
      );

  Widget fillEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: ccController,
              inputFormatters: [ccMaskFormatter],
              keyboardType: TextInputType.number,
              maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (_) =>
                  cardBloc.ccInputSink.add(ccMaskFormatter.getMaskedText()),
              decoration: const InputDecoration(
                  labelText: "Credit Card Number",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: expController,
              inputFormatters: [expMaskFormatter],
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (_) =>
                  cardBloc.expInputSink.add(expMaskFormatter.getMaskedText()),
              decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "MM/YY",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 3,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: cardBloc.cvvInputSink.add,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelText: "CVV",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.text,
              maxLength: 20,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: cardBloc.nameInputSink.add,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "Name on card",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      );

  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            gradient: LinearGradient(colors: UIData.kitGradients)),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          icon: const Icon(
            FontAwesomeIcons.amazonPay,
            color: Colors.white,
          ),
          label: const Text(
            "Continue",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Credit Card"),
      ),
      body: bodyData(),
      floatingActionButton: floatingBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
