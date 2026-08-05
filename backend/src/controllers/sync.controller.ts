import { Response, NextFunction } from 'express';
import * as syncService from '../services/sync.service';
import { AuthRequest } from '../types';

export const syncPush = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const payload = req.body;
    const userId = req.user?.userId;
    const result = await syncService.syncPush(payload, userId);
    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
};

export const syncPull = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const since = req.query.since as string | undefined;
    const result = await syncService.syncPull(since);
    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
};
