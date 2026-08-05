import { Response, NextFunction } from 'express';
import * as issueService from '../services/issue.service';
import { AuthRequest } from '../types';
import { z } from 'zod';

const createIssueSchema = z.object({
  id: z.string().optional(),
  title: z.string().min(1, 'Title is required'),
  category: z.enum(['ROAD', 'EDUCATION', 'WATER', 'SOCIETY']),
  status: z.enum(['DRAFT', 'PENDING_SYNC', 'SUBMITTED', 'VERIFIED', 'REVISION_REQUESTED']).optional(),
  problemDescription: z.string().min(1, 'Problem description is required'),
  actionTaken: z.string().min(1, 'Action taken is required'),
  expenditureDetails: z.string().optional(),
  villageId: z.string().min(1, 'Village ID is required'),
  reportedDate: z.string().optional(),
  resolvedDate: z.string().optional(),
  submittedById: z.string().optional(),
  beforePhotoUrls: z.array(z.string()).optional(),
  afterPhotoUrls: z.array(z.string()).optional(),
  documentUrls: z.array(z.string()).optional(),
});

const updateIssueSchema = createIssueSchema.partial();

const updateStatusSchema = z.object({
  status: z.enum(['DRAFT', 'PENDING_SYNC', 'SUBMITTED', 'VERIFIED', 'REVISION_REQUESTED']),
  adminReviewNote: z.string().optional(),
  note: z.string().optional(),
});

export const getAllIssues = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const { category, status, villageId, submittedBy, search, limit, offset } = req.query;
    const issues = await issueService.getAllIssues({
      category: category as string,
      status: status as string,
      villageId: villageId as string,
      submittedBy: submittedBy as string,
      search: search as string,
      limit: limit ? Number(limit) : undefined,
      offset: offset ? Number(offset) : undefined,
    });
    res.status(200).json(issues);
  } catch (error) {
    next(error);
  }
};

export const getIssueById = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const issue = await issueService.getIssueById(id);
    res.status(200).json(issue);
  } catch (error) {
    next(error);
  }
};

export const createIssue = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const data = createIssueSchema.parse(req.body);
    const userId = req.user?.userId;
    const issue = await issueService.createIssue(data, userId);
    res.status(201).json(issue);
  } catch (error) {
    next(error);
  }
};

export const updateIssue = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const data = updateIssueSchema.parse(req.body);
    const issue = await issueService.updateIssue(id, data);
    res.status(200).json(issue);
  } catch (error) {
    next(error);
  }
};

export const updateIssueStatus = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const { status, adminReviewNote, note } = updateStatusSchema.parse(req.body);
    const issue = await issueService.updateIssueStatus(id, status, adminReviewNote, note);
    res.status(200).json(issue);
  } catch (error) {
    next(error);
  }
};

export const deleteIssue = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    await issueService.deleteIssue(id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};
