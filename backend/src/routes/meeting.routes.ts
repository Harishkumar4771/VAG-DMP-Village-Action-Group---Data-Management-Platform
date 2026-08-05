import { Router } from 'express';
import * as meetingController from '../controllers/meeting.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

router.get('/', meetingController.getAllMeetings);
router.get('/:id', meetingController.getMeetingById);
router.post('/', authenticate, meetingController.createMeeting);
router.put('/:id', authenticate, meetingController.updateMeeting);
router.delete('/:id', authenticate, meetingController.deleteMeeting);

export default router;
