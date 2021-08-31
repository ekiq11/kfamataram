import 'package:flutter/material.dart';
import 'package:kf_online/view/login.dart';

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: currentIndex == dataLength - 1
          ? [
              Expanded(
                child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 70.0,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },

                        // add this
                        child: Container(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 17.0, top: 17.0),
                          child: Text(
                            "Get started",
                            style: Theme.of(context).textTheme.button,
                          ),
                        )))),
              )
            ]
          : [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ))
                ],
              )
            ],
    );
  }
}
