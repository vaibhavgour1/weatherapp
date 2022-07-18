import 'package:auth_app/home_screen/bloc/home_bloc.dart';
import 'package:auth_app/home_screen/bloc/home_event.dart';
import 'package:auth_app/home_screen/bloc/home_state.dart';
import 'package:auth_app/home_screen/response/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  CityData? cityData;

  @override
  void initState() {
    bloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
            create: (context) => bloc,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is GetUserState) {
                  cityData = state.cityData;
                  print(state.cityData.count);
                }
                if (state is WaitingState) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (state is FailureState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (cityData == null) {
                  return Center(child: const CircularProgressIndicator());
                }

                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,

                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Weather History",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: cityData!.list!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.70,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${DateFormat("EEE dd.mm.yyyy - hh:ss").format(DateTime.parse(cityData!.list![index].dt.toString()))}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Light Rain (${cityData!.list![index].rain} mm)",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Wind: (${cityData!.list![index].wind!.speed.toString()} m/s)",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Pressure: (${cityData!.list![index].main!.pressure.toString()} hpa)",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Humidity: (${cityData!.list![index].main!.humidity.toString()} %)",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.20,
                                        child: Column(
                                          children: [
                                            Icon(Icons.cloud),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${cityData!.list![index].main!.temp.toString()} C",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 0),
                                                child: Text(
                                                  "${cityData!.list![index].name.toString()}",
                                                  style: TextStyle(
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
                                Divider(
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
}
