#!/usr/bin/env node

const { program } = require('commander');
const chalk = require('chalk');
const chokidar = require('chokidar');
const ora = require('ora');
const path = require('path');
const fs = require('fs');
const { scanWorkspace } = require('./src/scanner');
const { compileLatex, compileTypst } = require('./src/compiler');
const { parseLatexLog, parseTypstOutput } = require('./src/parser');
const { showMainMenu, showCompilationOptions } = require('./src/ui');

async function main() {
    console.log(chalk.bold.blue('LaTeX & Typst Compilation System'));

    // Determine root directory.
    // If we are in the tool directory, scan the parent.
    let rootDir = process.cwd();

    // Heuristic: if current dir is LatexTypstCompiler, assume parent is root.
    if (path.basename(rootDir) === 'LatexTypstCompiler') {
        const parentDir = path.dirname(rootDir);
        // Verify parent has some project-like structure
        if (fs.existsSync(path.join(parentDir, '.git')) ||
            fs.existsSync(path.join(parentDir, 'Lecture Assignments')) ||
            fs.existsSync(path.join(parentDir, 'Practical Assignments'))) {
            rootDir = parentDir;
            console.log(chalk.gray(`Detected project root at: ${rootDir}`));
        }
    } else {
        // Try to find git root
        let current = rootDir;
        while (current !== path.parse(current).root) {
            if (fs.existsSync(path.join(current, '.git'))) {
                rootDir = current;
                console.log(chalk.gray(`Detected project root at: ${rootDir}`));
                break;
            }
            current = path.dirname(current);
        }
    }

    const spinner = ora('Scanning workspace...').start();

    try {
        const files = await scanWorkspace(rootDir);
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
                await runCompilation(selectedFile, options);
            });

            // Initial compile
            await runCompilation(selectedFile, options);
        } else {
            await runCompilation(selectedFile, options);
        }

    } catch (err) {
        spinner.stop();
        console.error(chalk.red('An error occurred:'), err);
    }
}

async function runCompilation(file, options) {
    const spinner = ora(`Compiling ${file.name}...`).start();
    const startTime = Date.now();

    let result;
    if (file.type === 'latex') {
        result = await compileLatex(file.path, options);
    } else {
        result = await compileTypst(file.path, options);
    }

    const duration = ((Date.now() - startTime) / 1000).toFixed(2);
    spinner.stop();

    if (result.success) {
        console.log(chalk.green(`✔ Compilation successful in ${duration}s`));
    } else {
        console.log(chalk.red(`✖ Compilation failed`));

        if (file.type === 'latex') {
            const errors = parseLatexLog(result.output);
            if (errors.length > 0) {
                console.log(chalk.bold('\nErrors:'));
                errors.forEach(err => {
                    console.log(chalk.red(`  ${err.file}:${err.line} - ${err.message}`));
                });
            } else {
                // Fallback if parser misses something
                console.log(chalk.yellow('Could not parse specific errors. Output tail:'));
                console.log(result.output.slice(-500));
            }
        } else {
            // Typst errors
            console.log(chalk.red(result.output));
        }
    }
}

main();
