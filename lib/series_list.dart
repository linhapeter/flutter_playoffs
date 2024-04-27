import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeriesList extends StatelessWidget {
  final List<Map<String, dynamic>> series;

  const SeriesList({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: series.length,
      itemBuilder: (context, index) {
        final serie = series[index];
        return GestureDetector(
          onTap: () {
            print(serie['seriesLetter']);
            Navigator.pushNamed(
              context,
             
            '/serieDetail',
            arguments: {
              'seriesLetter' :  serie['seriesLetter'].toLowerCase(),
              'topLogo' : serie['topLogo'],
              'bottomLogo' : serie['bottomLogo'],
              'topId' : serie['topId'],
              'bottomId' : serie['bottomId'],
            }
            );
          },
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),  // Set maximum width to 600 pixels
              child: Card(
                margin: EdgeInsets.all(8.0),
                color: Colors.grey[850],  // Set the Card background color to a dark shade
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            serie['topLogo'] == 'empty' ?
                            Image.asset(
                              'assets/images/nhl-filled-logo.png',
                              width: 60,
                            ) :
                            SvgPicture.network(
                              serie['topLogo'],
                              width: 60,
                              placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                serie['top'],
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        serie['score'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                serie['bottom'],
                                style: TextStyle(color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(width: 10),
                            serie['bottomLogo'] == 'empty' ?
                            Image.asset(
                              'assets/images/nhl-filled-logo.png',
                              width: 60,
                            ) :
                            SvgPicture.network(
                              serie['bottomLogo'],
                              width: 60,
                              placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
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
      },
    );
  }
}
