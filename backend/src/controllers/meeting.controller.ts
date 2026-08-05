import { Request, Response, NextFunction } from 'express';
import * as meetingService from '../services/meeting.service';
import { AuthRequest } from '../types';
import { z } from 'zod';

const createMeetingSchema = z.object({
  id: z.string().optional(),
  villageId: z.string().min(1, 'Village ID is required'),
  date: z.string().min(1, 'Date is required'),
  attendeesCount: z.number().int().min(0),
  status: z.enum(['SCHEDULED', 'COMPLETED', 'CANCELLED']).optional(),
  notes: z.string().optional(),
  photoUrls: z.array(z.string()).optional(),
});

const updateMeetingSchema = createMeetingSchema.partial();

export const getAllMeetings = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const villageId = req.query.villageId as string | undefined;
    const status = req.query.status as string | undefined;
    const search = req.query.search as string | undefined;
    const meetings = await meetingService.getAllMeetings({ villageId, status });
    res.status(200).json(meetings);
  } catch (error) {
    next(error);
  }
};

export const getMeetingById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const meeting = await meetingService.getMeetingById(id);
    res.status(200).json(meeting);
  } catch (error) {
    next(error);
  }
};

export const createMeeting = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const data = createMeetingSchema.parse(req.body);
    const meeting = await meetingService.createMeeting(data);
    res.status(201).json(meeting);
  } catch (error) {
    next(error);
  }
};

export const updateMeeting = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const data = updateMeetingSchema.parse(req.body);
    const meeting = await meetingService.updateMeeting(id, data);
    res.status(200).json(meeting);
  } catch (error) {
    next(error);
  }
};

export const deleteMeeting = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    await meetingService.deleteMeeting(id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};
