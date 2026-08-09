import { Response, NextFunction } from 'express';
import * as issueService from '../services/issue.service';
import { AuthRequest } from '../types';
import { z } from 'zod';

const createIssueSchema = z.object({
  id: z.string().optional(),
  local_uuid: z.string().optional(),
  title: z.string().min(1, 'Title is required'),
  category: z.enum(['road', 'education', 'water', 'society']),
  status: z.enum(['reported', 'in_progress', 'escalated', 'resolved']).optional(),
  description: z.string().min(1, 'Problem description is required'),
  action_taken: z.string().optional(),
  priority: z.enum(['low', 'medium', 'high', 'critical']).optional(),
  village_id: z.string().min(1, 'Village ID is required'),
  leader_id: z.string().optional(),
  created_at: z.string().optional(),
  resolved_at: z.string().optional(),
  attachments: z.array(z.object({
    type: z.enum(['before_photo', 'after_photo', 'gp_letter', 'receipt', 'other']),
    storage_path: z.string()
  })).optional()
});

const updateIssueSchema = createIssueSchema.partial();

const updateStatusSchema = z.object({
  status: z.enum(['reported', 'in_progress', 'escalated', 'resolved']),
  verification_notes: z.string().optional(),
  remarks: z.string().optional(),
});

export const getAllIssues = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const { category, status, village_id, leader_id, search, limit, offset } = req.query;
    const issues = await issueService.getAllIssues({
      category: category as string,
      status: status as string,
      village_id: village_id as string,
      leader_id: leader_id as string,
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
    const issue = await issueService.createIssue(data as any, userId);
    res.status(201).json(issue);
  } catch (error) {
    next(error);
  }
};

export const updateIssue = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const data = updateIssueSchema.parse(req.body);
    const userId = req.user?.userId;
    const issue = await issueService.updateIssue(id, data as any, userId);
    res.status(200).json(issue);
  } catch (error) {
    next(error);
  }
};

export const updateIssueStatus = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const { status, verification_notes, remarks } = updateStatusSchema.parse(req.body);
    const userId = req.user?.userId;
    const issue = await issueService.updateIssueStatus(id, status as any, verification_notes, remarks, userId);
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
