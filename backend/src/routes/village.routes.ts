import { Router } from 'express';
import * as villageController from '../controllers/village.controller';
import { authenticate, authorize } from '../middlewares/auth.middleware';

const router = Router();

router.get('/', villageController.getAllVillages);
router.get('/:id', villageController.getVillageById);
router.post('/', authenticate, authorize(['ADMIN']), villageController.createVillage);
router.put('/:id', authenticate, authorize(['ADMIN']), villageController.updateVillage);
router.delete('/:id', authenticate, authorize(['ADMIN']), villageController.deleteVillage);

export default router;
