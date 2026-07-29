import { Request, Response, NextFunction } from 'express';
import * as authService from '../services/auth.service';
import { z } from 'zod';

const requestOtpSchema = z.object({
  phone: z.string().min(10),
});

const verifyOtpSchema = z.object({
  phone: z.string().min(10),
  otp: z.string().length(6),
});

const registerSchema = z.object({
  id: z.string().uuid(),
  name: z.string(),
  phone: z.string().min(10),
  role: z.enum(['LEADER', 'ADMIN']),
  villageId: z.string().optional(),
});

export const requestOtp = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { phone } = requestOtpSchema.parse(req.body);
    await authService.requestOtp(phone);
    res.status(200).json({ message: 'OTP sent successfully' });
  } catch (error) {
    next(error);
  }
};

export const verifyOtp = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { phone, otp } = verifyOtpSchema.parse(req.body);
    const { user, token } = await authService.verifyOtp(phone, otp);
    res.status(200).json({ user, token });
  } catch (error) {
    next(error);
  }
};

export const register = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = registerSchema.parse(req.body);
    const user = await authService.register(data);
    res.status(201).json(user);
  } catch (error) {
    next(error);
  }
};
