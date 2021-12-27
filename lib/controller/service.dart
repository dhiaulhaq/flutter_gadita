// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:movie_db/core/model/movie_resp.dart';
//
// class Service {
//   String url =
//       'https://api.themoviedb.org/3/movie/now_playing?api_key=MASUKANAPIKEYKAMUDISINI&language=en-US&page=1&region=ID';
//   String upComingUrl =
//       'https://api.themoviedb.org/3/movie/upcoming?api_key=MASUKANAPIKEYKAMUDISINI&language=en-US&page=1';
//
//
//   Future<MovieResp> getUpcoming() async {
//     try {
//       print('Request : $upComingUrl');
//
//       ///hit api
//       final response = await http.get(upComingUrl);
//
//       if (response.statusCode == 200) {
//         /// jika response status code 200 atw berhasil maka json akan dimapping dan di decode
//         Map json = jsonDecode(response.body);
//         print('responsenya : ' + json.toString());
//
//         MovieResp movieResp = MovieResp.fromJson(json);
//         return movieResp;
//       } else {
//         ///jika gagal
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//   Future<MovieResp> getNowPlaying() async {
//     try {
//       print('Request : $upComingUrl');
//
//       final response = await http.get(upComingUrl);
//
//       if (response.statusCode == 200) {
//         Map json = jsonDecode(response.body);
//         print('responsenya : ' + json.toString());
//
//         MovieResp movieResp = MovieResp.fromJson(json);
//         return movieResp;
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }