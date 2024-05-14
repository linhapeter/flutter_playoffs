import 'package:flutter/material.dart';
import 'navigator_widget.dart'; // Assuming this is a custom screen for initial content in each tab
import 'api_service.dart'; // Assuming this is where ApiService is defined
import 'custom_bottom_nav_bar.dart'; // Ensure this is the correct path to the custom bottom nav bar
import 'custom_top_nav_bar.dart';
import 'playoff_fab.dart'; // Ensure this is the correct path to the custom top nav bar
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  List<Map<String, dynamic>> r1Series = [];
  List<Map<String, dynamic>> r2Series = [];
  List<Map<String, dynamic>> cfSeries = [];
  List<Map<String, dynamic>> scfSeries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4); // Number of tabs
    loadSeriesData();
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  }

  void loadSeriesData() async {
    try {
      List<Map<String, dynamic>> seriesData = await ApiService().fetchSeries();
      // Filter the series data by series abbreviation
      setState(() {
        r1Series = seriesData.where((s) => s['seriesAbbrev'] == 'R1').toList();
        r2Series = seriesData.where((s) => s['seriesAbbrev'] == 'R2').toList();
        cfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'ECF' || s['seriesAbbrev'] == 'WCF').toList();
        scfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'SCF').toList();
        _isLoading = false; // Data has been loaded
      });
    } catch (e) {
      // Handle the error here, e.g., show a snackbar or a dialog
      print("Error fetching series data: $e");
      setState(() {
        _isLoading = false; // Even if there's an error, stop the loading indicator
      });
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index; // Sync the TabController with the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Height of your custom app bar
        child: CustomTopNavBar(
          currentIndex: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while data is loading
          : TabBarView(
              controller: _tabController,
              children: [
                NavigatorWidget(index: 1, seriesData: r1Series),
                NavigatorWidget(index: 2, seriesData: r2Series),
                NavigatorWidget(index: 3, seriesData: cfSeries),
                NavigatorWidget(index: 4, seriesData: scfSeries),
              ],
            ),
      bottomNavigationBar: !kIsWeb && !Platform.isWindows ? CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ): null,
      floatingActionButton: const PlayoffFAB(),
    );
  }
}
