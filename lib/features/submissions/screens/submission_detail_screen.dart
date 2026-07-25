import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';

class SubmissionDetailScreen extends ConsumerWidget {
  final String submissionId;

  const SubmissionDetailScreen({
    super.key,
    required this.submissionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncIssue = ref.watch(issueByIdProvider(submissionId));

    return Scaffold(
      backgroundColor: AppColors.backgroundCream ?? const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Submission Details'),
      ),
      body: asyncIssue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (issue) {
          if (issue == null) {
            return const Center(child: Text('Submission not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryBanner(issue.category),
                const SizedBox(height: 16),
                _buildSectionTitle('Problem'),
                _buildSectionCard(issue.problemDescription),
                const SizedBox(height: 16),
                _buildSectionTitle('Action Taken'),
                _buildSectionCard(issue.actionTaken),
                if (issue.expenditureDetails != null && issue.expenditureDetails!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildSectionTitle('Expenditure Details'),
                  _buildSectionCard(issue.expenditureDetails!),
                ],
                const SizedBox(height: 16),
                _buildPhotosSection(context, 'Before Photos', issue.beforePhotoPaths),
                const SizedBox(height: 16),
                _buildPhotosSection(context, 'After Photos', issue.afterPhotoPaths),
                const SizedBox(height: 16),
                _buildPhotosSection(context, 'Documents', issue.documentPaths),
                if (issue.status == SubmissionStatus.revisionRequested && issue.adminReviewNote != null) ...[
                  const SizedBox(height: 16),
                  _buildSectionTitle('Admin Review Note', color: Colors.red),
                  _buildSectionCard(issue.adminReviewNote!, isAlert: true),
                ],
                const SizedBox(height: 16),
                _buildSectionTitle('Timeline'),
                _buildTimeline(issue),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryBanner(IssueCategory category) {
    IconData icon;
    Color color;
    String label;
    switch (category) {
      case IssueCategory.road:
        icon = Icons.construction_rounded;
        color = const Color(0xFF6D4C41);
        label = 'Road & Infrastructure';
        break;
      case IssueCategory.education:
        icon = Icons.school_rounded;
        color = const Color(0xFF5E35B1);
        label = 'Education & Schools';
        break;
      case IssueCategory.society:
        icon = Icons.groups_rounded;
        color = const Color(0xFFE65100);
        label = 'Society & Community';
        break;
      case IssueCategory.water:
        icon = Icons.water_drop_rounded;
        color = const Color(0xFF0288D1);
        label = 'Drinking Water';
        break;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSectionCard(String content, {bool isAlert = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAlert ? Colors.red.shade50 : (AppColors.surfaceCard ?? Colors.white),
        borderRadius: BorderRadius.circular(12),
        border: isAlert ? Border.all(color: Colors.red.shade200) : null,
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          color: isAlert ? Colors.red.shade900 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildPhotosSection(BuildContext context, String title, List<String> paths) {
    if (paths.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: paths.length,
            itemBuilder: (context, index) {
              final path = paths[index];
              return GestureDetector(
                onTap: () => _showImageDialog(context, path),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(path),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String path) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: InteractiveViewer(
            child: Image.file(File(path)),
          ),
        );
      },
    );
  }

  Widget _buildTimeline(Issue issue) {
    if (issue.timeline.isEmpty) {
      return const Text('No timeline available', style: TextStyle(color: Colors.grey));
    }
    return Column(
      children: issue.timeline.map((entry) {
        // Assume entry has some properties like date and description
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.timeline),
          title: Text(entry.toString()), // Placeholder based on generic domain model
        );
      }).toList(),
    );
  }
}
