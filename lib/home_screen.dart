import 'package:flutter/material.dart';
import 'navigator_widget.dart'; 
import 'api_service.dart'; 
import 'custom_bottom_nav_bar.dart';
import 'custom_top_nav_bar.dart';
import 'playoff_fab.dart'; 
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
    _tabController = TabController(vsync: this, length: 4); 
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
      
      setState(() {
        r1Series = seriesData.where((s) => s['seriesAbbrev'] == 'R1').toList();
        r2Series = seriesData.where((s) => s['seriesAbbrev'] == 'R2').toList();
        cfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'ECF' || s['seriesAbbrev'] == 'WCF').toList();
        scfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'SCF').toList();
        _isLoading = false; 
      });
    } catch (e) {
      
      print("Error fetching series data: $e");
      setState(() {
        _isLoading = false; 
      });
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), 
        child: CustomTopNavBar(
          currentIndex: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) 
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
