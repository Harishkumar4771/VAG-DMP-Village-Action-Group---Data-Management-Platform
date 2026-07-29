import { Router } from 'express';
import * as authController from '../controllers/auth.controller';

const router = Router();

router.post('/request-otp', authController.requestOtp);
router.post('/verify-otp', authController.verifyOtp);
router.post('/register', authController.register);

export default router;
