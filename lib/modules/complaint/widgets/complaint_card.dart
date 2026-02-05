import 'package:flutter/material.dart';
import 'package:learning_2/core/theme/app_colors.dart';
import 'package:learning_2/core/theme/app_fonts.dart';
import 'package:learning_2/modules/complaint/models/complaint_model.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard(this.complaint, {super.key});

  final ComplaintModel complaint;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(),
            const SizedBox(height: 12),
            _sectionBody(),
            const SizedBox(height: 12),
            _sectionFooter(),
          ],
        ),
      ),
    );
  }

  // ============= HEADER: ID + Status Badge =============
  Widget _sectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Complaint ID
        Text(
          complaint.complainId,
          style: AppFonts.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(complaint.statusText).withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            complaint.statusText,
            style: AppFonts.caption.copyWith(
              color: _getStatusColor(complaint.statusText),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ============= BODY: Details =============
  Widget _sectionBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          complaint.complainTitle,
          style: AppFonts.subtitle.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        // Category
        Text(
          complaint.categoryName,
          style: AppFonts.body.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        // Tenant + Date Row
        Row(
          children: [
            Icon(Icons.person, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(complaint.launchedBy?.name ?? '', style: AppFonts.caption),
            const Spacer(),
            Icon(
              Icons.calendar_today,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(complaint.launchedOn, style: AppFonts.caption),
          ],
        ),
        const SizedBox(height: 4),
        // Description
        Row(
          children: [
            Flexible(
              child: Text(
                complaint.complainDescription,
                style: AppFonts.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============= FOOTER: Action Buttons =============
  Widget _sectionFooter() {
    if (complaint.statusText == 'Pending') {
      return Row(
        children: [
          // Reject Button
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Reject',
                style: AppFonts.button.copyWith(color: AppColors.error),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Approve Button
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.success),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Approve',
                style: AppFonts.button.copyWith(color: AppColors.success),
              ),
            ),
          ),
        ],
      );
    } else if (complaint.statusText == 'InProgress') {
      return Row(
        children: [
          // Resolve Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.resolved,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Resolve',
                style: AppFonts.button.copyWith(color: AppColors.textOnPrimary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Comments Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.inProgress,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Comments',
                style: AppFonts.button.copyWith(color: AppColors.textOnPrimary),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.inProgress,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Comments',
                style: AppFonts.button.copyWith(color: AppColors.textOnPrimary),
              ),
            ),
          ),
        ],
      );
    }
  }

  // ============= Helper: Get Status Color =============
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.pending;
      case 'inprogress':
        return AppColors.inProgress;
      case 'resolved':
        return AppColors.resolved;
      case 'rejected':
        return AppColors.rejected;
      default:
        return AppColors.textSecondary;
    }
  }
}
