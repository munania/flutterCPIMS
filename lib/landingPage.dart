import 'dart:convert';
import 'package:cpims/widgets/dashboardCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/dashboardSummary.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DashBoardSummary? _dashboardSummary;
  bool _isLoading = true;
  String _error = '';

  Future<void> _fetchDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final String endpoint = 'https://dev.cpims.net/api/dashboard/';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final DashBoardSummary dashboardSummary = DashBoardSummary.fromJson(responseData);
        setState(() {
          _dashboardSummary = dashboardSummary;
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = 'Error fetching data. Please try again later.';
        });
      }
    } else {
       setState(() {
        _isLoading = false;
        _error = 'No token available.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _dashboardSummary == null
            ? const CircularProgressIndicator() // Show loading indicator while fetching data
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  DashboardCard(
                    title: 'Children',
                    value: _dashboardSummary!.children.toString(),
                  ),
                  DashboardCard(
                    title: 'Caregivers',
                    value: _dashboardSummary!.caregivers.toString(),
                  ),
                   DashboardCard(
                            title: 'Government',
                            value: _dashboardSummary!.government.toString(),
                          ),
                          DashboardCard(
                            title: 'NGO',
                            value: _dashboardSummary!.ngo.toString(),
                          ),
                          DashboardCard(
                            title: 'Case Records',
                            value: _dashboardSummary!.caseRecords.toString(),
                          ),
                          DashboardCard(
                            title: 'Pending Cases',
                            value: _dashboardSummary!.pendingCases.toString(),
                          ),
                          DashboardCard(
                            title: 'Organization Units',
                            value: _dashboardSummary!.orgUnits.toString(),
                          ),
                          DashboardCard(
                            title: 'Organization Units',
                            value: _dashboardSummary!.orgUnit.toString(),
                          ),
                          DashboardCard(
                            title: 'Organization Unit Id',
                            value: _dashboardSummary!.orgUnitId.toString(),
                          ),
                          DashboardCard(
                            title: 'Details',
                            value: _dashboardSummary!.details.toString(),
                          ),
                          DashboardCard(
                            title: 'Workforce Members',
                            value: _dashboardSummary!.workforceMembers.toString(),
                          ),
                          DashboardCard(
                            title: 'Household',
                            value: _dashboardSummary!.household.toString(),
                          ),
                          DashboardCard(
                            title: 'All Chilfren',
                            value: _dashboardSummary!.childrenAll.toString(),
                          ),
                          DashboardCard(
                            title: 'Ovc Summary',
                            value: _dashboardSummary!.ovcSummary.f0.toString(),
                          ),
                          DashboardCard(
                            title: 'OVC Regs',
                            value: _dashboardSummary!.ovcRegs.toString(),
                          ),
                          DashboardCard(
                            title: 'Case Regs',
                            value: _dashboardSummary!.caseRegs.toString(),
                          ),
                          DashboardCard(
                            title: 'Case Cats',
                            value: _dashboardSummary!.caseCats.toString(),
                          ),
                          DashboardCard(
                            title: 'Criteria',
                            value: _dashboardSummary!.criteria.toString(),
                          ),
                          
                  // ... Add more DashboardCard widgets for other data fields
                ],
              ),
      ),
    );
  }
}

