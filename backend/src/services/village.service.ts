import prisma from '../config/db';
import { CreateVillageDto, UpdateVillageDto } from '../types';

export const getAllVillages = async (district?: string, search?: string) => {
  const where: any = {};

  if (district) {
    where.district = { contains: district, mode: 'insensitive' };
  }

  if (search) {
    where.OR = [
      { name: { contains: search, mode: 'insensitive' } },
      { district: { contains: search, mode: 'insensitive' } },
    ];
  }

  return await prisma.village.findMany({
    where,
    include: {
      _count: {
        select: {
          profiles: true,
          issues: true,
          meetings: true,
        },
      },
    },
    orderBy: { name: 'asc' },
  });
};

export const getVillageById = async (id: string) => {
  const village = await prisma.village.findUnique({
    where: { id },
    include: {
      profiles: {
        select: { id: true, full_name: true, phone: true, role: true },
      },
      issues: {
        take: 10,
        orderBy: { created_at: 'desc' },
      },
      meetings: {
        take: 10,
        orderBy: { scheduled_date: 'desc' },
      },
      _count: {
        select: {
          profiles: true,
          issues: true,
          meetings: true,
        },
      },
    },
  });

  if (!village) {
    const error: any = new Error('Village not found');
    error.status = 404;
    throw error;
  }
  return village;
};

export const createVillage = async (data: CreateVillageDto) => {
  return await prisma.village.create({
    data: {
      id: data.id,
      name: data.name,
      district: data.district,
      state: data.state || 'Maharashtra',
      taluka: data.taluka,
      gram_panchayat_name: data.gram_panchayat_name,
      chairman_name: data.chairman_name,
      chairman_phone: data.chairman_phone
    },
  });
};

export const updateVillage = async (id: string, data: UpdateVillageDto) => {
  return await prisma.village.update({
    where: { id },
    data,
  });
};

export const deleteVillage = async (id: string) => {
  return await prisma.village.delete({ where: { id } });
};
