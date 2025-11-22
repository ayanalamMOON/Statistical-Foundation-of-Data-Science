#!/usr/bin/env node

const { program } = require('commander');
const chalk = require('chalk');
const chokidar = require('chokidar');
const ora = require('ora');
const path = require('path');
const fs = require('fs');

const configManager = require('../src/lib/ConfigManager');
const compilerRegistry = require('../src/lib/CompilerRegistry');
const Scanner = require('../src/lib/Scanner');
const LatexCompiler = require('../src/lib/compilers/LatexCompiler');
const TypstCompiler = require('../src/lib/compilers/TypstCompiler');
const { showMainMenu, showCompilationOptions } = require('../src/ui');

// Register compilers
compilerRegistry.register(new LatexCompiler());
compilerRegistry.register(new TypstCompiler());

// --- Helper Functions ---

function getRootDir() {
    let rootDir = process.cwd();
    // Heuristic for root detection
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

async function runCompilation(filePath, options) {
    const compiler = compilerRegistry.getCompilerFor(filePath);
    if (!compiler) {
        console.error(chalk.red(`No compiler found for ${filePath}`));
        return;
    }

    const fileName = path.basename(filePath);
    const spinner = ora(`Compiling ${fileName}...`).start();
    const startTime = Date.now();

    // Merge CLI options with config options
    const finalOptions = { ...configManager.getAll(), ...options };

    const result = await compiler.compile(filePath, finalOptions);

    const duration = ((Date.now() - startTime) / 1000).toFixed(2);
    spinner.stop();

    if (result.success) {
        console.log(chalk.green(`✔ Compilation successful in ${duration}s`));
    } else {
        console.log(chalk.red(`✖ Compilation failed`));

        if (compiler.parseErrors) {
            const errors = compiler.parseErrors(result.output);
            if (errors.length > 0) {
                console.log(chalk.bold('\nErrors:'));
                errors.forEach(err => {
                    console.log(chalk.red(`  ${err.file}:${err.line} - ${err.message}`));
                });
            } else {
                console.log(chalk.yellow('Could not parse specific errors. Output tail:'));
                console.log(result.output.slice(-500));
            }
        } else {
            console.log(chalk.red(result.output));
        }
    }
}

// --- Commands ---

async function interactiveMode() {
    console.log(chalk.bold.blue('LaTeX & Typst Compilation System (Advanced)'));

    const rootDir = getRootDir();
    configManager.load(rootDir);
    console.log(chalk.gray(`Project Root: ${configManager.get('rootDir')}`));

    const scanner = new Scanner(configManager);
    const spinner = ora('Scanning workspace...').start();

    try {
        const files = await scanner.scan();
        spinner.stop();

        if (files.length === 0) {
            console.log(chalk.yellow('No .tex or .typ files found.'));
            return;
        }

        const selectedFile = await showMainMenu(files);
        if (!selectedFile) return;

        const options = await showCompilationOptions();

        if (options.watch) {
            console.log(chalk.blue(`\nStarting watch mode for ${selectedFile.name}...`));
            const watcher = chokidar.watch(selectedFile.path);

            watcher.on('change', async () => {
                console.log(chalk.gray(`\nFile changed. Recompiling...`));
                await runCompilation(selectedFile.path, options);
            });

            await runCompilation(selectedFile.path, options);
        } else {
            await runCompilation(selectedFile.path, options);
        }

    } catch (err) {
        spinner.stop();
        console.error(chalk.red('An error occurred:'), err);
    }
}

// --- CLI Definition ---

program
    .name('ltc')
    .description('Advanced LaTeX and Typst Compiler')
    .version('1.0.0');

program
    .command('compile <file>')
    .description('Compile a specific file')
    .option('-w, --watch', 'Watch for changes')
    .action(async (file, options) => {
        const rootDir = getRootDir();
        configManager.load(rootDir); // Load config for CLI commands

        const filePath = path.resolve(process.cwd(), file);
        if (!fs.existsSync(filePath)) {
            console.error(chalk.red(`File not found: ${filePath}`));
            process.exit(1);
        }

        if (options.watch) {
            console.log(chalk.blue(`Starting watch mode for ${path.basename(filePath)}...`));
            const watcher = chokidar.watch(filePath);
            watcher.on('change', async () => {
                console.log(chalk.gray(`\nFile changed. Recompiling...`));
                await runCompilation(filePath, options);
            });
            await runCompilation(filePath, options);
        } else {
            await runCompilation(filePath, options);
        }
    });

program
    .command('init')
    .description('Initialize a configuration file')
    .action(() => {
        const configPath = path.join(process.cwd(), '.ltc.json');
        const defaultConfig = {
            rootDir: process.cwd(),
            ignorePatterns: ['**/node_modules/**'],
            outputDir: null
        };
        fs.writeFileSync(configPath, JSON.stringify(defaultConfig, null, 2));
        console.log(chalk.green(`Created .ltc.json in ${process.cwd()}`));
    });

// Default action: Interactive Mode
program
    .action(() => {
        interactiveMode();
    });

program.parse(process.argv);
