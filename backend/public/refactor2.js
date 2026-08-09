const fs = require('fs');

function refactorFile(file) {
  let content = fs.readFileSync(file, 'utf8');

  // progress updates -> history
  content = content.replace(/\.progressUpdates/g, '.history');
  
  // attendeesCount -> attendees count is not in Meeting anymore, attendees is an array
  content = content.replace(/\.attendees_count/g, '?.attendees?.length || 0');

  // Meeting date -> scheduled_date
  content = content.replace(/\.date/g, '.scheduled_date');
  content = content.replace(/date:/g, 'scheduled_date:');

  // Issue title is still title
  fs.writeFileSync(file, content);
  console.log('Refactored 2: ' + file);
}

refactorFile('backend/public/app.js');
refactorFile('backend/public/index.html');
