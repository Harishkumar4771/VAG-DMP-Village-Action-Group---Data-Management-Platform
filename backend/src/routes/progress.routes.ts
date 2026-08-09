import { Router } from 'express';
import * as progressController from '../controllers/progress.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

// GET /v1/issues/:issueId/progress — Get all progress updates for an issue
router.get('/:issueId/progress', progressController.getProgressUpdates);

// POST /v1/issues/:issueId/progress — Add a progress update
router.post('/:issueId/progress', authenticate, progressController.addProgressUpdate);

// GET /v1/progress/reminders — Get all follow-up reminders
router.get('/', progressController.getReminders);

export default router;
