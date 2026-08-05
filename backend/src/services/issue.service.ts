import prisma from '../config/db';
import { CreateIssueDto, UpdateIssueDto, SubmissionStatus, IssueCategory, MediaType } from '../types';

export const getAllIssues = async (filters?: {
  category?: string;
  status?: string;
  villageId?: string;
  submittedBy?: string;
  search?: string;
  limit?: number;
  offset?: number;
}) => {
  const where: any = {};

  if (filters?.category) {
    where.category = filters.category as IssueCategory;
  }

  if (filters?.status) {
    where.status = filters.status as SubmissionStatus;
  }

  if (filters?.villageId) {
    where.villageId = filters.villageId;
  }

  if (filters?.submittedBy) {
    where.submittedById = filters.submittedBy;
  }

  if (filters?.search) {
    where.OR = [
      { title: { contains: filters.search, mode: 'insensitive' } },
      { problemDescription: { contains: filters.search, mode: 'insensitive' } },
      { actionTaken: { contains: filters.search, mode: 'insensitive' } },
    ];
  }

  const [items, total] = await Promise.all([
    prisma.issue.findMany({
      where,
      include: {
        village: {
          select: { id: true, name: true, district: true },
        },
        submittedBy: {
          select: { id: true, name: true, phone: true },
        },
        media: true,
        timeline: {
          orderBy: { date: 'asc' },
        },
      },
      orderBy: { createdAt: 'desc' },
      take: filters?.limit ? Number(filters.limit) : 50,
      skip: filters?.offset ? Number(filters.offset) : 0,
    }),
    prisma.issue.count({ where }),
  ]);

  return { items, total };
};

export const getIssueById = async (id: string) => {
  const issue = await prisma.issue.findUnique({
    where: { id },
    include: {
      village: true,
      submittedBy: {
        select: { id: true, name: true, phone: true, role: true },
      },
      media: true,
      timeline: {
        orderBy: { date: 'asc' },
      },
    },
  });

  if (!issue) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  return issue;
};

export const createIssue = async (data: CreateIssueDto, fallbackUserId?: string) => {
  const id = data.id || `iss_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;
  const submittedById = data.submittedById || fallbackUserId;

  if (!submittedById) {
    const error: any = new Error('SubmittedBy user ID is required');
    error.status = 400;
    throw error;
  }

  const reportedDate = data.reportedDate ? new Date(data.reportedDate) : new Date();

  // Create issue along with media and initial timeline entry
  const mediaCreates: any[] = [];
  if (data.beforePhotoUrls) {
    for (const url of data.beforePhotoUrls) {
      mediaCreates.push({ url, type: 'BEFORE' as MediaType });
    }
  }
  if (data.afterPhotoUrls) {
    for (const url of data.afterPhotoUrls) {
      mediaCreates.push({ url, type: 'AFTER' as MediaType });
    }
  }
  if (data.documentUrls) {
    for (const url of data.documentUrls) {
      mediaCreates.push({ url, type: 'DOCUMENT' as MediaType });
    }
  }

  const status = data.status || 'SUBMITTED';

  return prisma.issue.create({
    data: {
      id,
      title: data.title,
      category: data.category,
      status,
      problemDescription: data.problemDescription,
      actionTaken: data.actionTaken,
      expenditureDetails: data.expenditureDetails,
      villageId: data.villageId,
      submittedById,
      reportedDate,
      resolvedDate: data.resolvedDate ? new Date(data.resolvedDate) : null,
      timeline: {
        create: [
          {
            status: 'SUBMITTED',
            date: reportedDate,
            note: 'Submission recorded',
            completed: true,
          },
        ],
      },
      media: {
        create: mediaCreates,
      },
    },
    include: {
      village: true,
      submittedBy: true,
      media: true,
      timeline: true,
    },
  });
};

export const updateIssue = async (id: string, data: UpdateIssueDto) => {
  const existing = await prisma.issue.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  const updateData: any = { ...data };
  if (data.resolvedDate) {
    updateData.resolvedDate = new Date(data.resolvedDate);
  }

  return prisma.issue.update({
    where: { id },
    data: updateData,
    include: {
      village: true,
      media: true,
      timeline: true,
    },
  });
};

export const updateIssueStatus = async (
  id: string,
  status: SubmissionStatus,
  adminReviewNote?: string,
  note?: string
) => {
  const existing = await prisma.issue.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  const isResolved = status === 'VERIFIED';
  const resolvedDate = isResolved ? new Date() : existing.resolvedDate;

  return prisma.issue.update({
    where: { id },
    data: {
      status,
      adminReviewNote: adminReviewNote || existing.adminReviewNote,
      resolvedDate,
      timeline: {
        create: {
          status,
          date: new Date(),
          note: note || (adminReviewNote ? `Admin Note: ${adminReviewNote}` : `Status updated to ${status}`),
          completed: status === 'VERIFIED',
        },
      },
    },
    include: {
      village: true,
      media: true,
      timeline: { orderBy: { date: 'asc' } },
    },
  });
};

export const deleteIssue = async (id: string) => {
  const existing = await prisma.issue.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  // Delete associated timeline and media first
  await prisma.issueTimelineEntry.deleteMany({ where: { issueId: id } });
  await prisma.media.deleteMany({ where: { issueId: id } });

  return prisma.issue.delete({ where: { id } });
};
