const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const cors = require('cors');
const path = require('path');
const fs = require('fs');
const execa = require('execa');

const configManager = require('./src/lib/ConfigManager');
const compilerRegistry = require('./src/lib/CompilerRegistry');
const Scanner = require('./src/lib/Scanner');
const LatexCompiler = require('./src/lib/compilers/LatexCompiler');
const TypstCompiler = require('./src/lib/compilers/TypstCompiler');

// Register compilers
compilerRegistry.register(new LatexCompiler());
compilerRegistry.register(new TypstCompiler());

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "http://localhost:5173", // Vite default port
        methods: ["GET", "POST"]
    }
});

app.use(cors());
app.use(express.json());

// --- Helper to get Root Dir (reused logic) ---
function getRootDir() {
    let rootDir = process.cwd();
    if (path.basename(rootDir) === 'LatexTypstCompiler') {
        const parentDir = path.dirname(rootDir);
        if (fs.existsSync(path.join(parentDir, '.git')) ||
            fs.existsSync(path.join(parentDir, 'Lecture Assignments'))) {
            rootDir = parentDir;
        }
    } else {
        let current = rootDir;
        while (current !== path.parse(current).root) {
            if (fs.existsSync(path.join(current, '.git'))) {
                rootDir = current;
                break;
            }
            current = path.dirname(current);
        }
    }
    return rootDir;
}

const execa = require('execa');

// ... imports

// Initialize Config
const rootDir = getRootDir();
configManager.load(rootDir);
console.log(`Project Root: ${configManager.get('rootDir')}`);

// Serve static files from project root for PDF preview
app.use('/files', express.static(rootDir));

// --- API Endpoints ---

app.post('/api/open', async (req, res) => {
    const { filePath } = req.body;
    if (!filePath) return res.status(400).json({ error: 'filePath is required' });

    try {
        // Try opening with VS Code
        await execa('code', [filePath]);
        res.json({ success: true });
    } catch (err) {
        console.error('Failed to open in VS Code:', err);
        // Fallback to system open (start on windows)
        try {
            await execa('start', [filePath], { shell: true });
            res.json({ success: true });
        } catch (err2) {
            res.status(500).json({ error: err2.message });
        }
    }
});

app.get('/api/scan', async (req, res) => {
    const scanner = new Scanner(configManager);
    try {
        const files = await scanner.scan();
        res.json(files);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get('/api/config', (req, res) => {
    res.json(configManager.getAll());
});

app.post('/api/compile', async (req, res) => {
    const { filePath, options } = req.body;

    if (!filePath) {
        return res.status(400).json({ error: 'filePath is required' });
    }

    const compiler = compilerRegistry.getCompilerFor(filePath);
    if (!compiler) {
        return res.status(400).json({ error: 'No compiler found for this file type' });
    }

    // Notify client compilation started
    io.emit('log', { type: 'info', message: `Starting compilation for ${path.basename(filePath)}...` });

    try {
        const finalOptions = { ...configManager.getAll(), ...options };
        const result = await compiler.compile(filePath, finalOptions);

        if (result.success) {
            io.emit('log', { type: 'success', message: 'Compilation successful!' });
            res.json({ success: true, output: result.output });
        } else {
            io.emit('log', { type: 'error', message: 'Compilation failed.' });

            // Send detailed errors via socket
            if (compiler.parseErrors) {
                const errors = compiler.parseErrors(result.output);
                errors.forEach(err => {
                    io.emit('log', { type: 'error', message: `${err.file}:${err.line} - ${err.message}` });
                });
            } else {
                io.emit('log', { type: 'error', message: result.output });
            }

            res.json({ success: false, output: result.output });
        }
    } catch (err) {
        io.emit('log', { type: 'error', message: `Internal Error: ${err.message}` });
        res.status(500).json({ error: err.message });
    }
});

// --- Socket.io ---
io.on('connection', (socket) => {
    console.log('Client connected');
    socket.on('disconnect', () => {
        console.log('Client disconnected');
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
