import 'package:auth_app/home_screen/bloc/home_bloc.dart';
import 'package:auth_app/home_screen/bloc/home_event.dart';
import 'package:auth_app/home_screen/bloc/home_state.dart';
import 'package:auth_app/home_screen/response/response.dart';
import 'package:auth_app/model/model.dart';
import 'package:auth_app/sqldb/data_base_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../sqldb/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  List<WeatherModel> userdata = [];
  List<WeatherModel> userdatareverd = [];
  CityData? cityData;

  String cityName = "";

  @override
  void initState() {
    bloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottum = MediaQuery.of(context).viewPadding.bottom;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
            create: (context) => bloc,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is GetUserState) {
                  int id = new DateTime.now().millisecondsSinceEpoch;
                  cityData = state.cityData;
                  cityName = cityData!.list!.first.name;
                  print("uuid.hashCode-->${uuid.hashCode}");
                  WeatherModel data = WeatherModel(
                      id: id,
                      name: cityData!.list!.first.name,
                      dt: cityData!.list!.first.dt.toString(),
                      speed: cityData!.list!.first.wind!.speed.toString(),
                      humidity: cityData!.list!.first.main!.humidity.toString(),
                      lightRain: cityData!.list!.first.rain ?? "not",
                      pressure: cityData!.list!.first.main!.pressure,
                      temp: cityData!.list!.first.main!.temp);
                  init(data);
                  Utility.setStringPreference(Utility.userId, id.toString());
                  print("data--->${data.toMap()}");
                }
                if (state is GetCityState) {
                  int id = new DateTime.now().millisecondsSinceEpoch;
                  cityData = state.cityData;
                  cityName = cityData!.list!.first.name;
                  WeatherModel data = WeatherModel(
                      id: id,
                      name: cityData!.list!.first.name,
                      dt: cityData!.list!.first.dt.toString(),
                      speed: cityData!.list!.first.wind!.speed.toString(),
                      humidity: cityData!.list!.first.main!.humidity.toString(),
                      lightRain: cityData!.list!.first.rain ?? "not",
                      pressure: cityData!.list!.first.main!.pressure,
                      temp: cityData!.list!.first.main!.temp);
                  init(data);
                  Utility.setStringPreference(Utility.userId, id.toString());
                  print(state.cityData.count);
                }
                if (state is WaitingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FailureState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (cityData == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: h * 0.45,
                      width: w,
                      color: Colors.blue,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cityName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      bloc.add(GetUserEvent());
                                    },
                                    icon: const Icon(Icons.refresh_sharp,
                                        color: Colors.white, size: 25),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      var x = await showSearch(
                                          context: context,
                                          // delegate to customize the search bar
                                          delegate: CustomSearchDelegate());
                                      print("x----$x");
                                      if (x != null) {
                                        bloc.add(GetCityEvent(city: x));
                                      }
                                    },
                                    icon: const Icon(Icons.search_outlined,
                                        color: Colors.white, size: 25),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.white, size: 25),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.030,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cityData!.list!.first.main!.temp} °C",
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: h * 0.010,
                                  ),
                                  Text(
                                    cityData!
                                        .list!.first.weather!.first.description,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: h * 0.010,
                                  ),
                                  Text(
                                    "Wind ${cityData!.list!.first.wind!.speed}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "pressure ${cityData!.list!.first.main!.pressure}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "humidity ${cityData!.list!.first.main!.humidity}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Sunrise ${cityData!.list!.first.main!.pressure}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Sunset ${cityData!.list!.first.main!.pressure}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "UV Index ${cityData!.list!.first.main!.pressure}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, w * 0.060, h * 0.080),
                                    child: const Icon(
                                      Icons.cloud,
                                      size: 110,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Last update :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "15:30",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          "Weather History",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: userdatareverd.reversed.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.70,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${DateFormat("EEE dd.mm.yyyy - hh:ss").format(DateTime.parse(userdatareverd[index].dt.toString()))}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Light Rain (${userdatareverd[index].lightRain} mm)",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Wind: (${userdatareverd[index].speed.toString()} m/s)",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Pressure: (${userdatareverd[index].pressure.toString()} hpa)",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Humidity: (${userdatareverd[index].humidity.toString()} %)",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        child: Column(
                                          children: [
                                            const Icon(Icons.cloud),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${userdatareverd[index].temp.toString()} C",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 0),
                                                child: Text(
                                                  "${userdatareverd[index].name.toString()}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  void init(WeatherModel data) async {
    await DatabaseHelper.addWeatherData(data);
    userdata = await DatabaseHelper.getWeatherData();
    userdatareverd = userdata.reversed.toList();
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> cityList = [
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Bangalore",
    "Chennai",
    "Hyderabad",
    "Ahmadabad",
    "Surat",
    "Pune",
    "Jaipur",
    "Indore",
    "Bhopal",
    "Agra",
    "Patna",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in cityList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in cityList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            query = result;
            Navigator.pop(context, query);
          },
          title: Text(result),
        );
      },
    );
  }
}
