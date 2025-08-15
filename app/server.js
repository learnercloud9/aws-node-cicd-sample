// app/server.js
const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Hello from CodePipeline + CodeBuild + CodeDeploy ✅' });
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

// Export app for tests; start server only if this file is run directly
if (require.main === module) {
  app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
} else {
  module.exports = app;
}
