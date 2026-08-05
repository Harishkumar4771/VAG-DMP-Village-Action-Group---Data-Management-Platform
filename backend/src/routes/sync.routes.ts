import { Router } from 'express';
import * as syncController from '../controllers/sync.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

router.post('/push', authenticate, syncController.syncPush);
router.get('/pull', authenticate, syncController.syncPull);

export default router;
