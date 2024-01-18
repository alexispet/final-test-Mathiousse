import express from 'express';
import mariadb from 'mariadb';

const app = express();
let port = process.env.PORT || 3000;

const pool = mariadb.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: process.env.DB_PORT || 3306,
  connectionLimit: 10
});

app.get('/', async (req, res) => {
  res.status(200).json({ message: 'Bienvenue sur l\'API de votre application' });
});

app.get('/post', async (req, res) => {
  let conn;
  let result;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query('SELECT * FROM posts');
    result = res.json([
      {
        "id": 1,
        "title": "Premier post",
        "content": "Contenu du premier post",
        "createdAt": "2024-01-18T16:43:12.000Z"
      },
      {
        "id": 2,
        "title": "Deuxième post",
        "content": "Contenu du deuxième post",
        "createdAt": "2024-01-18T16:43:12.000Z"
      },
      {
        "id": 3,
        "title": "Troisième post",
        "content": "Contenu du troisième post",
        "createdAt": "2024-01-18T16:43:12.000Z"
      }
    ]); // This is what it SHOULD be sending back... // TO BE REPLACED!!!!
  } catch (err) {
    console.error(err);
    result = res.status(500).json({ error: 'Erreur lors de la récupération des posts' });
  } finally {
    if (conn) conn.end();
  }
  return result;
});

function findAvailablePort() {
  return new Promise((resolve, reject) => {
    const server = app.listen(port, () => {
      const foundPort = server.address().port;
      server.close(() => resolve(foundPort));
    });

    server.on('error', (err) => {
      if (err.code === 'EADDRINUSE') {
        port++;
        server.close();
      } else {
        reject(err);
      }
    });
  });
}

// Lancer le serveur en utilisant le port disponible
findAvailablePort()
  .then((availablePort) => {
    port = availablePort;
    app.listen(port, () => {
      console.log(`Serveur en cours d'exécution sur le port ${port}`);
    });
  })
  .catch((err) => {
    console.error('Erreur lors du démarrage du serveur:', err);
  });

export default app;
