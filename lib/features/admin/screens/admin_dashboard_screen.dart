import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/core/constants/app_constants.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.push('/admin/notifications'),
          ),
        ],
      ),
      body: isWeb ? _buildWebLayout(context, ref) : _buildMobileLayout(context, ref),
    );
  }

  Widget _buildMobileLayout(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildWelcomeCard(),
        const SizedBox(height: 16),
        _buildStatsGrid(ref, isWeb: false),
        const SizedBox(height: 16),
        _buildQuickActions(context),
        const SizedBox(height: 16),
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildRecentActivityList(ref),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Export Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildStatsGrid(ref, isWeb: true),
        const SizedBox(height: 24),
        const Text(
          'Recent Submissions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildRecentSubmissionsTable(ref),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16), // radiusLg equivalent
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Monitoring 850+ villages',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(WidgetRef ref, {required bool isWeb}) {
    final issuesAsync = ref.watch(issuesProvider);
    final pendingCountAsync = ref.watch(pendingVerificationCountProvider);
    final verifiedMonthAsync = ref.watch(verifiedThisMonthProvider);

    return GridView.count(
      crossAxisCount: isWeb ? 4 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: isWeb ? 1.5 : 1.2,
      children: [
        _buildStatCard(
          title: 'Total Submissions',
          value: issuesAsync.when(
            data: (issues) => issues.length.toString(),
            loading: () => '...',
            error: (_, __) => '-',
          ),
          icon: Icons.list_alt,
          color: const Color(0xFF2E7D32),
        ),
        _buildStatCard(
          title: 'Pending Verification',
          value: pendingCountAsync.when(
            data: (count) => count.toString(),
            loading: () => '...',
            error: (_, __) => '-',
          ),
          icon: Icons.pending_actions,
          color: const Color(0xFFF9A825), // Gold
        ),
        _buildStatCard(
          title: 'Verified This Month',
          value: verifiedMonthAsync.when(
            data: (count) => count.toString(),
            loading: () => '...',
            error: (_, __) => '-',
          ),
          icon: Icons.verified,
          color: const Color(0xFF4CAF50),
        ),
        if (isWeb)
          _buildStatCard(
            title: 'Critical Issues',
            value: '5',
            icon: Icons.warning_amber,
            color: const Color(0xFFE64A19), // Terracotta
          ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ActionChip(
          label: const Text('Verify Pending'),
          avatar: const Icon(Icons.check_circle_outline, size: 16),
          onPressed: () => context.push('/admin/verify'),
        ),
        ActionChip(
          label: const Text('Manage Villages'),
          avatar: const Icon(Icons.location_city, size: 16),
          onPressed: () {},
        ),
        ActionChip(
          label: const Text('Generate Reports'),
          avatar: const Icon(Icons.picture_as_pdf, size: 16),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildRecentActivityList(WidgetRef ref) {
    final issuesAsync = ref.watch(issuesProvider);

    return issuesAsync.when(
      data: (issues) {
        if (issues.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No recent activity.'),
          );
        }
        final recentIssues = issues.take(5).toList();
        return Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentIssues.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final issue = recentIssues[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                  child: const Icon(Icons.update, color: Color(0xFF2E7D32)),
                ),
                title: Text(issue.title),
                subtitle: Text('${issue.villageName} • ${issue.status.name}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/admin/verify/${issue.id}'),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildRecentSubmissionsTable(WidgetRef ref) {
    final issuesAsync = ref.watch(issuesProvider);

    return issuesAsync.when(
      data: (issues) {
        return Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Village')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: issues.take(10).map((issue) {
                return DataRow(
                  cells: [
                    DataCell(Text(issue.id.substring(0, 6))),
                    DataCell(Text(issue.title)),
                    DataCell(Text(issue.villageName)),
                    DataCell(Text(issue.category.name)),
                    DataCell(
                      Chip(
                        label: Text(
                          issue.status.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: issue.status == SubmissionStatus.verified
                            ? const Color(0xFF2E7D32).withOpacity(0.1)
                            : Colors.grey.shade200,
                      ),
                    ),
                    DataCell(
                      TextButton(
                        onPressed: () {
                          // TODO: Navigate using go_router context.push for web
                        },
                        child: const Text('View'),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
