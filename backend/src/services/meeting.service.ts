import prisma from '../config/db';
import { CreateMeetingDto, UpdateMeetingDto, MeetingStatus, MeetingType } from '../types';

export const getAllMeetings = async (filters?: { village_id?: string; status?: string }) => {
  const where: any = {};
  if (filters?.village_id) where.village_id = filters.village_id;
  if (filters?.status) where.status = filters.status as MeetingStatus;

  return await prisma.meeting.findMany({
    where,
    include: {
      village: { select: { id: true, name: true, district: true } },
      attendees: true,
    },
    orderBy: { scheduled_date: 'desc' },
  });
};

export const getMeetingById = async (id: string) => {
  const meeting = await prisma.meeting.findUnique({
    where: { id },
    include: { village: true, attendees: true },
  });
  
  if (!meeting) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }
  return meeting;
};

export const createMeeting = async (data: CreateMeetingDto) => {
  const scheduled_date = new Date(data.scheduled_date);
  
  const attendeeCreates = data.attendees?.map(a => ({
    name: a.name,
    role: a.role,
    present: a.present
  })) || [];

  return await prisma.meeting.create({
    data: {
      id: data.id,
      local_uuid: data.local_uuid,
      village_id: data.village_id,
      type: data.type,
      title: data.title,
      scheduled_date,
      status: data.status || 'upcoming',
      agenda: data.agenda,
      minutes_notes: data.minutes_notes,
      attendees: { create: attendeeCreates },
    },
    include: { village: true, attendees: true },
  });
};

export const updateMeeting = async (id: string, data: UpdateMeetingDto) => {
  const updateData: any = { ...data };
  if (data.scheduled_date) updateData.scheduled_date = new Date(data.scheduled_date);
  
  return await prisma.meeting.update({
    where: { id },
    data: updateData,
    include: { village: true, attendees: true },
  });
};

export const deleteMeeting = async (id: string) => {
  return await prisma.meeting.delete({ where: { id } });
};
