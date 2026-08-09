const fs = require('fs');

function refactorFile(file) {
  let content = fs.readFileSync(file, 'utf8');

  // Fields
  content = content.replace(/villageId/g, 'village_id');
  content = content.replace(/submittedBy/g, 'leader_id');
  content = content.replace(/submittedById/g, 'leader_id');
  content = content.replace(/reportedDate/g, 'created_at');
  content = content.replace(/resolvedDate/g, 'resolved_at');
  content = content.replace(/problemDescription/g, 'description');
  content = content.replace(/actionTaken/g, 'action_taken');
  content = content.replace(/expenditureDetails/g, 'expenditure'); // no expenditure in issue model, but ok for logic
  content = content.replace(/attendeesCount/g, 'attendees_count');

  // issue.media -> issue.attachments
  content = content.replace(/\.media/g, '.attachments');

  // Enums for Issues
  content = content.replace(/'REPORTED'/g, "'reported'");
  content = content.replace(/'IN_PROGRESS'/g, "'in_progress'");
  content = content.replace(/'ACTION_INITIATED'/g, "'in_progress'");
  content = content.replace(/'COMPLETED'/g, "'resolved'");
  content = content.replace(/'VERIFIED'/g, "'resolved'");
  content = content.replace(/'SUBMITTED'/g, "'reported'");
  content = content.replace(/'REVISION_REQUESTED'/g, "'escalated'");

  // Enums for Categories
  content = content.replace(/'WATER'/g, "'water'");
  content = content.replace(/'ROAD'/g, "'road'");
  content = content.replace(/'EDUCATION'/g, "'education'");
  content = content.replace(/'SOCIETY'/g, "'society'");

  // Enums for Meetings
  content = content.replace(/'SCHEDULED'/g, "'upcoming'");
  content = content.replace(/'CANCELLED'/g, "'cancelled'");
  
  // Timeline/progress fix
  content = content.replace(/\.timeline/g, '.history');

  fs.writeFileSync(file, content);
  console.log('Refactored: ' + file);
}

refactorFile('backend/public/app.js');
refactorFile('backend/public/index.html');
