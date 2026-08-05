import { Request, Response, NextFunction } from 'express';
import * as villageService from '../services/village.service';
import { z } from 'zod';

const createVillageSchema = z.object({
  id: z.string().optional(),
  name: z.string().min(1, 'Village name is required'),
  district: z.string().min(1, 'District is required'),
  state: z.string().optional(),
  memberCount: z.number().int().min(0).optional(),
  lastActivity: z.string().optional(),
  status: z.string().optional(),
});

const updateVillageSchema = createVillageSchema.partial();

export const getAllVillages = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const district = req.query.district as string | undefined;
    const search = req.query.search as string | undefined;
    const villages = await villageService.getAllVillages(district, search);
    res.status(200).json(villages);
  } catch (error) {
    next(error);
  }
};

export const getVillageById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const village = await villageService.getVillageById(id);
    res.status(200).json(village);
  } catch (error) {
    next(error);
  }
};

export const createVillage = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = createVillageSchema.parse(req.body);
    const village = await villageService.createVillage(data);
    res.status(201).json(village);
  } catch (error) {
    next(error);
  }
};

export const updateVillage = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    const data = updateVillageSchema.parse(req.body);
    const village = await villageService.updateVillage(id, data);
    res.status(200).json(village);
  } catch (error) {
    next(error);
  }
};

export const deleteVillage = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = req.params.id as string;
    await villageService.deleteVillage(id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};
