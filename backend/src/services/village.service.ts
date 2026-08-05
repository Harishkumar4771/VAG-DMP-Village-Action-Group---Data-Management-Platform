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

  return prisma.village.findMany({
    where,
    include: {
      _count: {
        select: {
          users: true,
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
      users: {
        select: { id: true, name: true, phone: true, role: true },
      },
      issues: {
        take: 10,
        orderBy: { createdAt: 'desc' },
      },
      meetings: {
        take: 10,
        orderBy: { date: 'desc' },
      },
      _count: {
        select: {
          users: true,
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
  const id = data.id || `vlg_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;

  return prisma.village.create({
    data: {
      id,
      name: data.name,
      district: data.district,
      state: data.state || 'Maharashtra',
      memberCount: data.memberCount || 0,
      lastActivity: data.lastActivity || new Date().toISOString(),
      status: data.status || 'Active',
    },
  });
};

export const updateVillage = async (id: string, data: UpdateVillageDto) => {
  const village = await prisma.village.findUnique({ where: { id } });
  if (!village) {
    const error: any = new Error('Village not found');
    error.status = 404;
    throw error;
  }

  return prisma.village.update({
    where: { id },
    data,
  });
};

export const deleteVillage = async (id: string) => {
  const village = await prisma.village.findUnique({ where: { id } });
  if (!village) {
    const error: any = new Error('Village not found');
    error.status = 404;
    throw error;
  }

  return prisma.village.delete({
    where: { id },
  });
};
