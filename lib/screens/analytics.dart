import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis/youtubereporting/v1.dart' as reporting;
import 'package:googleapis/youtubeanalytics/v2.dart' as analytics;
import 'package:googleapis_auth/auth_io.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Analytics extends StatefulWidget {
  final String accessToken;
  const Analytics({super.key, required this.accessToken});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String channelName = "";
  int subscriberCount = 0;
  int totalViews = 0;
  List<dynamic>? topVideos;

  @override
  void initState() {
    super.initState();
    _getChannelData(widget.accessToken);
    // _getTopVideos(widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: TitledContainer(
                // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                // padding: const EdgeInsets.all(16.0),
                title: 'youtube',
                backgroundColor: Colors.transparent,
                titleColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Channel Name: $channelName',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Subscribers: $subscriberCount',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Views: $totalViews',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: TitledContainer(
                // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                // padding: const EdgeInsets.all(16.0),
                title: 'youtube',
                backgroundColor: Colors.transparent,
                titleColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Channel Name: $channelName',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Subscribers: $subscriberCount',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Views: $totalViews',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text(
            //     'Top Videos:',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // if (topVideos != null)
            //   ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: topVideos!.length,
            //     itemBuilder: (context, index) {
            //       final video = topVideos![index];
            //       final videoTitle = video[0];
            //       final viewCount = video[1];
            //       return ListTile(
            //         title: Text(videoTitle),
            //         trailing: Text('Views: $viewCount'),
            //       );
            //     },
            //   )
            // else
            //   const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Future<void> _getChannelData(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    const apiKey = 'AIzaSyDbsbYtVxbo15IHRL6HM241F5Oquir9qGg';
    final authHeaders = {'Authorization': 'Bearer $accessToken'};

    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/channels?part=snippet%2Cstatistics&mine=true&key'),
      headers: authHeaders,
    );

    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var channel = jsonData['items'][0];

        setState(() {
          channelName = channel['snippet']['title'];
          subscriberCount = int.parse(channel['statistics']['subscriberCount']);
          totalViews = int.parse(channel['statistics']['viewCount']);
        });
      } else {
        print("the accesstoken : $accessToken ");
        print('Error fetching channel data: ${response.statusCode}');
        print('Error Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error processing channel data: $e');
    }
  }

  // Future<void> _getTopVideos(String accessToken) async {
  //   final httpClient = await clientViaApiKey(accessToken);
  //   final analyticsApi = analytics.YouTubeAnalyticsApi(httpClient);
  //   try {
  //     var result = await analyticsApi.reports.query(
  //       ids: 'channel==MINE',
  //       startDate: '2020-01-01',
  //       endDate: '2024-10-02',
  //       metrics: 'views',
  //       dimensions: 'video',
  //       sort: '-views',
  //       maxResults: 10,
  //     );
  //     setState(() {
  //       topVideos = result.rows;
  //     });
  //   } catch (e) {
  //     print('Error fetching analytics data: $e');
  //   }
  // }
}
