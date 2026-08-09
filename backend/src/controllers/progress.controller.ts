import { Response, NextFunction } from 'express';
import * as progressService from '../services/progress.service';
import { AuthRequest } from '../types';
import { z } from 'zod';

const createProgressUpdateSchema = z.object({
  type: z.enum(['15_DAY', '1_MONTH']),
  status: z.enum(['NOT_STARTED', 'WORK_IN_PROGRESS', 'WAITING_APPROVAL', 'WAITING_RESOURCES', 'COMPLETED']),
  description: z.string().min(1, 'Description is required'),
  photoDataUrl: z.string().optional(),
  expenditure: z.string().optional(),
  notes: z.string().optional(),
});

export const getProgressUpdates = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const issueId = req.params.issueId as string;
    const updates = await progressService.getProgressUpdates(issueId);
    res.status(200).json(updates);
  } catch (error) {
    next(error);
  }
};

export const addProgressUpdate = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const issueId = req.params.issueId as string;
    const data = createProgressUpdateSchema.parse(req.body);
    const update = await progressService.addProgressUpdate(issueId, data);
    res.status(201).json(update);
  } catch (error) {
    next(error);
  }
};

export const getReminders = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const reminders = await progressService.getReminders();
    res.status(200).json(reminders);
  } catch (error) {
    next(error);
  }
};
