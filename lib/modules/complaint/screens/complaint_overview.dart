import 'package:flutter/material.dart';
import 'package:learning_2/core/theme/app_colors.dart';
import 'package:learning_2/core/theme/app_fonts.dart';
import 'package:learning_2/modules/complaint/models/complaint_model.dart';
import 'package:learning_2/modules/complaint/widgets/complaint_card.dart';

class ComplaintOverviewScreen extends StatefulWidget {
  const ComplaintOverviewScreen({super.key});

  @override
  State<ComplaintOverviewScreen> createState() =>
      _ComplaintOverviewScreenState();
}

class _ComplaintOverviewScreenState extends State<ComplaintOverviewScreen> {
  // ============= STATE VARIABLES =============
  // Use String? (nullable) so dropdown can show hint when nothing selected
  String? selectedLocation;
  String? selectedTenant;

  // ============= DUMMY DATA =============
  // These lists will come from API later
  final List<String> locations = [
    'All Locations',
    'Tower A',
    'Tower B',
    'Tower C',
  ];

  final List<String> tenants = [
    'All Tenants',
    'Tenant 1',
    'Tenant 2',
    'Tenant 3',
  ];

  final List<ComplaintModel> todayComplaints = [];

  final List<ComplaintModel> activeComplaints = [
    ComplaintModel(
      complainId: 'COM-001',
      complainCategoryId: 'CAT-001',
      categoryName: 'Parking Issues',
      complainTitle: 'No parking available',
      complainDescription: 'There is no valet parking',
      complainStatus: 1,
      statusText: 'Pending',
      launchedBy: LaunchedBy(id: 'TEN-001', name: 'John Doe'),
      launchedOn: '2026-01-10',
      dateOfIncidence: '2026-01-10',
      photoUrls: [],
      videoUrls: [],
      viewHistory: [],
    ),
    ComplaintModel(
      complainId: 'COM-002',
      complainCategoryId: 'CAT-002',
      categoryName: 'Maintenance Issues',
      complainTitle: 'Leakage in the kitchen',
      complainDescription: 'There is a leakage in the kitchen',
      complainStatus: 2,
      statusText: 'InProgress',
      launchedBy: LaunchedBy(id: 'TEN-002', name: 'Dyson'),
      launchedOn: '2025-12-11',
      dateOfIncidence: '2025-12-11',
      photoUrls: [],
      videoUrls: [],
      viewHistory: [],
    ),
  ];

  final List<ComplaintModel> pastComplaints = [
    ComplaintModel(
      complainId: 'COM-004',
      complainCategoryId: 'CAT-004',
      categoryName: 'Infrastructure Issues',
      complainTitle: 'No proper infrastructure',
      complainDescription: 'There is no proper infrastructure',
      complainStatus: 5,
      statusText: 'Rejected',
      launchedBy: LaunchedBy(id: 'TEN-003', name: 'Shreyash'),
      launchedOn: '2025-12-10',
      dateOfIncidence: '2025-12-10',
      photoUrls: [],
      videoUrls: [],
      viewHistory: [],
    ),
    ComplaintModel(
      complainId: 'COM-005',
      complainCategoryId: 'CAT-005',
      categoryName: 'Billing Issues',
      complainTitle: 'They are charging too much',
      complainDescription: 'They are charging more than the actual price',
      complainStatus: 3,
      statusText: 'Resolved',
      launchedBy: LaunchedBy(id: 'TEN-004', name: 'Karan'),
      launchedOn: '2025-12-11',
      dateOfIncidence: '2025-12-11',
      photoUrls: [],
      videoUrls: [],
      viewHistory: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Complaint Overview',
            style: AppFonts.title.copyWith(color: AppColors.textOnPrimary),
          ),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // ============= DROPDOWN ROW =============
              // Padding around the entire row
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Each dropdown wrapped in Expanded to share space equally
                    Expanded(child: _locationDropdown()),

                    // Space between the two dropdowns
                    const SizedBox(width: 12),

                    Expanded(child: _tenantDropdown()),
                  ],
                ),
              ),

              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primary,
                ),
                labelStyle: AppFonts.subtitle.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                unselectedLabelStyle: AppFonts.subtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                //indicatorColor: AppColors.primary,
                isScrollable: false,
                tabs: const [
                  Tab(text: 'Today'),
                  Tab(text: 'Active'),
                  Tab(text: 'Past'),
                ],
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    // Today Tab
                    if (todayComplaints.isNotEmpty)
                      ListView.builder(
                        itemCount: todayComplaints.length,
                        itemBuilder: (context, index) {
                          return ComplaintCard(todayComplaints[index]);
                        },
                      )
                    else
                      const Center(child: Text('No complaints found')),
                    // Active Tab
                    activeComplaints.isEmpty
                        ? const Center(child: Text('No complaints found'))
                        : ListView.builder(
                            itemCount: activeComplaints.length,
                            itemBuilder: (context, index) {
                              return ComplaintCard(activeComplaints[index]);
                            },
                          ),
                    // Past Tab
                    pastComplaints.isEmpty
                        ? const Center(child: Text('No complaints found'))
                        : ListView.builder(
                            itemCount: pastComplaints.length,
                            itemBuilder: (context, index) {
                              return ComplaintCard(pastComplaints[index]);
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============= LOCATION DROPDOWN =============
  // This is a private method (starts with _) so only this class can use it
  Widget _locationDropdown() {
    return DropdownButtonFormField<String>(
      // -------- VALUE --------
      // The currently selected value
      // When null, dropdown shows the hint
      value: selectedLocation,

      // -------- HINT --------
      // Shown when value is null (nothing selected yet)
      hint: Text(
        'Select Location',
        style: AppFonts.body.copyWith(color: AppColors.textHint),
      ),

      // -------- ICON --------
      // The dropdown arrow on the right
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),

      // -------- STYLE --------
      // Style for the selected item text
      style: AppFonts.body.copyWith(color: AppColors.textPrimary),

      // -------- IS EXPANDED --------
      // Makes dropdown take full width of parent
      isExpanded: true,

      // -------- ITEMS --------
      // List of options to show in dropdown
      // .map() transforms each String into a DropdownMenuItem widget
      items: locations.map((location) {
        return DropdownMenuItem<String>(
          value: location, // This is the actual value stored when selected
          child: Text(location), // This is what user sees
        );
      }).toList(),

      // -------- ON CHANGED --------
      // Called when user selects an option
      onChanged: (value) {
        // setState rebuilds the widget with new value
        setState(() {
          selectedLocation = value;
        });
        // You can add additional logic here, like:
        // print('Selected: $value');
        // filterComplaints(value);
      },

      // -------- DECORATION --------
      // Styling for the input field border, label, etc.
      decoration: InputDecoration(
        // Label shown above the dropdown (floats up when focused)
        labelText: 'Location',
        labelStyle: AppFonts.caption.copyWith(color: AppColors.textSecondary),

        // Prefix icon (left side)
        prefixIcon: const Icon(Icons.location_on, color: AppColors.primary),

        // Content padding inside the dropdown
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        // Normal border (when not focused)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        // Border when focused (user taps on it)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),

        // Border when enabled but not focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        // Background color (filled)
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }

  // ============= TENANT DROPDOWN =============

  Widget _tenantDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedTenant,
      hint: Text(
        'Select Tenant',
        style: AppFonts.body.copyWith(color: AppColors.textHint),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
      style: AppFonts.body.copyWith(color: AppColors.textPrimary),
      isExpanded: true,
      items: tenants.map((tenant) {
        return DropdownMenuItem<String>(value: tenant, child: Text(tenant));
      }).toList(),

      onChanged: (String? value) {
        setState(() {
          selectedTenant = value;
        });
        print(selectedTenant);
      },
      // -------- DECORATION --------
      // Styling for the input field border, label, etc.
      decoration: InputDecoration(
        // Label shown above the dropdown (floats up when focused)
        labelText: 'Tenant',
        labelStyle: AppFonts.caption.copyWith(color: AppColors.textSecondary),

        // Prefix icon (left side)
        prefixIcon: const Icon(Icons.person, color: AppColors.primary),

        // Content padding inside the dropdown
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        // Normal border (when not focused)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        // Border when focused (user taps on it)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),

        // Border when enabled but not focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        // Background color (filled)
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }
}
