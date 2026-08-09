import { Request, Response, NextFunction } from 'express';
import * as meetingService from '../services/meeting.service';
import { AuthRequest } from '../types';
import { z } from 'zod';

const createMeetingSchema = z.object({
  id: z.string().optional(),
  local_uuid: z.string().optional(),
  village_id: z.string().min(1, 'Village ID is required'),
  type: z.enum(['gram_sabha', 'committee']),
  title: z.string().optional(),
  scheduled_date: z.string().min(1, 'Scheduled Date is required'),
  status: z.enum(['upcoming', 'completed', 'cancelled']).optional(),
  agenda: z.string().optional(),
  minutes_notes: z.string().optional(),
  attendees: z.array(z.object({
    name: z.string(),
    role: z.string().optional(),
    present: z.boolean().optional(),
  })).optional(),
});

const updateMeetingSchema = createMeetingSchema.partial();

export const getAllMeetings = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const village_id = req.query.village_id as string | undefined;
    const status = req.query.status as string | undefined;
    const search = req.query.search as string | undefined;
    const meetings = await meetingService.getAllMeetings({ village_id, status });
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
    const meeting = await meetingService.createMeeting(data as any);
    res.status(201).json(meeting);
  } catch (error) {
    next(error);
  }
};

export const updateMeeting = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const data = updateMeetingSchema.parse(req.body);
    const meeting = await meetingService.updateMeeting(id, data as any);
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
