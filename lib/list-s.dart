import 'package:flutter/material.dart';

final List<String> openness = [
  'you have an active imagination',
      'get  excited by new ideas',
      'avoid philosophical discussions',
      'belive in the importance of art',
      'carry the conversation to a higer level',
      'always listen to the others ideas',
];
final List<String> conscientiousness = [
  'you does your work efficiently',
      'you tends to be lazy',
      'pay attention to details',
      'need a push to get started',
      'finish what i started',
      'shirk my duties',
];
final List<String> extraversion = [
  'make friend easily',
      'you are sociable',
      'you are sort tempered',
      "don't talk a lot ",
      "dont't like to draw attention to myself",
      'i am skilled in handling social situations',
];
final List<String> agreeableness = [
  'you are sometime rude to others',
      'you are soft harted',
      'easy to satisfy',
      'make demands on others',
      'sympathize with others feeling',
      'accept people the way they are',
];
final List<String> neuroticism =[
  'worries a lot',
      'get nervous easily',
      'handles stress well',
      'do you blush more often than most people',
      'have frequent mood swings',
      'do you have sometime feel that you can not overcome from your problems',
];

final List<String> option =
  ['strongly agree','agree','neither agree nor disagree','disagree','strongly disagree'];
class Test extends StatefulWidget {
  _list createState() => _list();
}

class _list extends State<Test> {
    bool isLoaded = false;
    int total,users;
    var width, height;
//    List<charts.Series<BarChartData, String>> series;
    List<int> grVal=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("APTITUTE TEST PAGE"),
        ),
        body: SafeArea(
          child: Container(
              child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
//                controller: ScrollController(),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: height/68),
                      height: height - height/5,
                      child: ListView.builder(
                        controller: ScrollController(),
//                        physics: ClampingScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index0) {
                          return Card(
                              child: Column(
                                  children: <Widget>[
                                    Text("${index0 + 1} "),
                                    ListTile(
                                      title: Text(openness[index0]),
                                      subtitle:
                                      ListView.builder(
                                        itemBuilder: (context, index1) {
                                          return RadioListTile(
                                              groupValue: grVal[index0],
                                              value: index1 + 1,
                                              selected: true,
                                              onChanged: (value) {
                                                setState(() {
//                                                  print(grVal);
                                                  grVal[index0] = value;
//                                                  print(grVal);
                                                });
                                              },
                                              activeColor: Colors.greenAccent,
                                              title: Text(
                                                  option[index1])
                                          );
                                        },
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        physics: ClampingScrollPhysics(),
                                      ),
                                    ),
                                  ]
                              )
                          );
                        },
                      ),
                    ),
                    RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blue[900],
                        textColor: Colors.blue[100],
                        child: Text("SUBMIT  ANSWERS"),
                        onPressed: () {

                        }
                    )

                  ]
              )
          ),
        ),
      ),
    );
  }

  }
