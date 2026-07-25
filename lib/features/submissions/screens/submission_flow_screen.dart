import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/core/constants/app_constants.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';
import 'package:vag_dmp_frontend/features/issues/data/models/issue_model.dart';
import 'package:vag_dmp_frontend/core/sync/sync_status.dart';
import 'package:vag_dmp_frontend/core/auth/auth_providers.dart';

class SubmissionFlowScreen extends ConsumerStatefulWidget {
  const SubmissionFlowScreen({super.key});

  @override
  ConsumerState<SubmissionFlowScreen> createState() => _SubmissionFlowScreenState();
}

class _SubmissionFlowScreenState extends ConsumerState<SubmissionFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Step 1 State
  IssueCategory? _selectedCategory;

  // Step 2 State
  final _formKey = GlobalKey<FormState>();
  final _problemController = TextEditingController();
  final _actionController = TextEditingController();
  final _expenditureController = TextEditingController();

  // Step 3 State
  List<String> _beforePhotos = [];
  List<String> _afterPhotos = [];
  List<String> _documents = [];

  final ImagePicker _picker = ImagePicker();

  void _nextPage() {
    if (_currentPage == 1 && !_formKey.currentState!.validate()) {
      return;
    }
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _pickImage(List<String> list, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        list.add(image.path);
      });
    }
  }

  Future<void> _submitReport() async {
    final user = ref.read(currentUserProvider);
    if (user == null || _selectedCategory == null) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    
    final issue = Issue(
      id: id,
      title: 'Report for ${_selectedCategory!.name}',
      problemDescription: _problemController.text,
      actionTaken: _actionController.text,
      villageId: user.villageId ?? 'unknown',
      villageName: user.villageName ?? 'Unknown Village',
      submittedBy: user.id,
      expenditureDetails: _expenditureController.text.isNotEmpty ? _expenditureController.text : null,
      resolutionNotes: null,
      adminReviewNote: null,
      category: _selectedCategory!,
      status: SubmissionStatus.pendingSync,
      reportedDate: DateTime.now(),
      resolvedDate: null,
      beforePhotoPaths: _beforePhotos,
      afterPhotoPaths: _afterPhotos,
      documentPaths: _documents,
      timeline: [], // Assuming empty initially
      syncStatus: SyncStatus.pendingCreate,
    );

    final issueModel = IssueModel.fromDomain(issue);
    final dataSource = ref.read(issueLocalDataSourceProvider);
    await dataSource.saveIssue(issueModel);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully')),
      );
      context.go('/leader/history');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _problemController.dispose();
    _actionController.dispose();
    _expenditureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream ?? const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          _currentPage == 0
              ? 'New Activity Report'
              : _currentPage == 1
                  ? '${_selectedCategory?.name ?? 'Details'} 📝'
                  : 'Attach Proof',
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '${_currentPage + 1} of 3',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
              ],
            ),
          ),
          _buildStepIndicator(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    final categories = [
      {'cat': IssueCategory.road, 'icon': Icons.construction_rounded, 'color': const Color(0xFF6D4C41), 'label': 'Road & Infrastructure'},
      {'cat': IssueCategory.education, 'icon': Icons.school_rounded, 'color': const Color(0xFF5E35B1), 'label': 'Education & Schools'},
      {'cat': IssueCategory.society, 'icon': Icons.groups_rounded, 'color': const Color(0xFFE65100), 'label': 'Society & Community'},
      {'cat': IssueCategory.water, 'icon': Icons.water_drop_rounded, 'color': const Color(0xFF0288D1), 'label': 'Drinking Water'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Problem Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final color = cat['color'] as Color;
                
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat['cat'] as IssueCategory;
                      });
                      _nextPage();
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'] as IconData, size: 48, color: Colors.white),
                          const SizedBox(height: 12),
                          Text(
                            cat['label'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _problemController,
                      label: 'Problem Statement',
                      hint: 'Describe the problem that was identified...',
                      maxLines: 3,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _actionController,
                      label: 'Action Taken & Panchayat Role',
                      hint: 'Explain how this was resolved with GP support...',
                      maxLines: 3,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _expenditureController,
                      label: 'Expenditure / Resource Details',
                      hint: 'e.g. Rs 5,000 for materials',
                      maxLines: 1,
                      isRequired: false,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _prevPage,
                  child: const Text('Back'),
                ),
                FilledButton(
                  onPressed: _nextPage,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLines,
    required bool isRequired,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: AppColors.surfaceCard ?? Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection('Before Photos', _beforePhotos),
                  const SizedBox(height: 24),
                  _buildImageSection('After Photos', _afterPhotos),
                  const SizedBox(height: 24),
                  _buildImageSection('Official Documents', _documents, subtitle: 'GP Letterhead, Bills, Receipts'),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: _prevPage,
                child: const Text('Back'),
              ),
              FilledButton.icon(
                onPressed: _submitReport,
                icon: const Icon(Icons.upload_file_rounded),
                label: const Text('Submit Report'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen ?? const Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(String title, List<String> paths, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () => _pickImage(paths, ImageSource.camera),
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () => _pickImage(paths, ImageSource.gallery),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (paths.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(paths[index]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              paths.removeAt(index);
                            });
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close, size: 16, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = index == _currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (AppColors.primaryGreen ?? const Color(0xFF2E7D32))
                  : Colors.grey.shade400,
            ),
          );
        }),
      ),
    );
  }
}
