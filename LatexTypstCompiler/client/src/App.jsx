import { AnimatePresence, motion } from 'framer-motion';
import { CheckCircle, Code, Eye, FileText, Loader2, Play, Search, Settings, Terminal, XCircle } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';
import { io } from 'socket.io-client';
import './App.css';

const socket = io('http://localhost:3000');

function App() {
    const [files, setFiles] = useState([]);
    const [logs, setLogs] = useState([]);
    const [compiling, setCompiling] = useState(false);
    const [selectedFile, setSelectedFile] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const logEndRef = useRef(null);

    useEffect(() => {
        fetchFiles();

        socket.on('log', (log) => {
            setLogs((prev) => [...prev, log]);
        });

        return () => {
            socket.off('log');
        };
    }, []);

    useEffect(() => {
        logEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, [logs]);

    const fetchFiles = async () => {
        try {
            const res = await fetch('http://localhost:3000/api/scan');
            const data = await res.json();
            setFiles(data);
        } catch (err) {
            console.error('Failed to fetch files', err);
        }
    };

    const handleCompile = async (file) => {
        setCompiling(true);
        setLogs([]);
        setSelectedFile(file);

        try {
            await fetch('http://localhost:3000/api/compile', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ filePath: file.path })
            });
        } catch (err) {
            console.error('Compilation request failed', err);
        } finally {
            setCompiling(false);
        }
    };

    const handleOpenInEditor = async (file) => {
        try {
            await fetch('http://localhost:3000/api/open', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ filePath: file.path })
            });
        } catch (err) {
            console.error('Failed to open file', err);
        }
    };

    const handlePreview = (file) => {
        // Logic moved to inline button click for simplicity in this version
    };

    const [config, setConfig] = useState(null);
    useEffect(() => {
        fetch('http://localhost:3000/api/config')
            .then(res => res.json())
            .then(data => setConfig(data));
    }, []);

    const getPreviewUrl = (file) => {
        if (!config) return null;
        // Replace .tex/.typ with .pdf
        const pdfPath = file.path.replace(/\.(tex|typ)$/, '.pdf');

        // Normalize paths to forward slashes for URL
        const normalizedRoot = config.rootDir.replace(/\\/g, '/');
        const normalizedPath = pdfPath.replace(/\\/g, '/');

        if (normalizedPath.startsWith(normalizedRoot)) {
            const relativePath = normalizedPath.substring(normalizedRoot.length);
            return `http://localhost:3000/files${relativePath}`;
        }
        return null;
    };

    const filteredFiles = files.filter(file =>
        file.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="app-container">
            <nav className="sidebar">
                <div className="logo">
                    <Terminal className="icon" />
                    <span>LTC Pro</span>
                </div>
                <div className="menu">
                    <div className="menu-item active">
                        <FileText className="icon" />
                        <span>Files</span>
                    </div>
                    <div className="menu-item">
                        <Settings className="icon" />
                        <span>Settings</span>
                    </div>
                </div>
            </nav>

            <main className="content">
                <header>
                    <h1>Workspace</h1>
                    <div className="header-actions">
                        <div className="search-bar">
                            <Search size={18} />
                            <input
                                type="text"
                                placeholder="Search files..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                            />
                        </div>
                        <button className="refresh-btn" onClick={fetchFiles}>Refresh</button>
                    </div>
                </header>

                <div className="grid">
                    <div className="file-list">
                        <h2>Detected Files</h2>
                        <div className="cards">
                            {filteredFiles.map((file) => (
                                <motion.div
                                    key={file.path}
                                    className={`card ${selectedFile?.path === file.path ? 'selected' : ''}`}
                                    whileHover={{ scale: 1.02 }}
                                    onClick={() => setSelectedFile(file)}
                                >
                                    <div className="card-icon">
                                        {file.type === 'latex' ? 'TeX' : 'Typ'}
                                    </div>
                                    <div className="card-info">
                                        <h3>{file.name}</h3>
                                        <p>{file.path}</p>
                                    </div>
                                    <div className="card-actions">
                                        <button
                                            className="action-btn"
                                            title="Open in Editor"
                                            onClick={(e) => { e.stopPropagation(); handleOpenInEditor(file); }}
                                        >
                                            <Code size={16} />
                                        </button>
                                        <button
                                            className="action-btn"
                                            title="Preview PDF"
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                const url = getPreviewUrl(file);
                                                if (url) window.open(url, '_blank');
                                            }}
                                        >
                                            <Eye size={16} />
                                        </button>
                                        <button
                                            className="compile-btn"
                                            onClick={(e) => { e.stopPropagation(); handleCompile(file); }}
                                            disabled={compiling}
                                            title="Compile"
                                        >
                                            {compiling && selectedFile?.path === file.path ? <Loader2 className="spin" /> : <Play size={16} />}
                                        </button>
                                    </div>
                                </motion.div>
                            ))}
                        </div>
                    </div>

                    <div className="terminal-window">
                        <div className="terminal-header">
                            <span>Output Log</span>
                            <button onClick={() => setLogs([])}>Clear</button>
                        </div>
                        <div className="terminal-body">
                            <AnimatePresence>
                                {logs.map((log, i) => (
                                    <motion.div
                                        key={i}
                                        initial={{ opacity: 0, x: -10 }}
                                        animate={{ opacity: 1, x: 0 }}
                                        className={`log-line ${log.type}`}
                                    >
                                        {log.type === 'success' && <CheckCircle size={14} />}
                                        {log.type === 'error' && <XCircle size={14} />}
                                        {log.type === 'info' && <Loader2 size={14} className={log.message.includes('Starting') ? 'spin' : ''} />}
                                        <span>{log.message}</span>
                                    </motion.div>
                                ))}
                            </AnimatePresence>
                            <div ref={logEndRef} />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    );
}

export default App;
