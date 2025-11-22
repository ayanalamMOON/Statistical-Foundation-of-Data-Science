const inquirer = require('inquirer');
const chalk = require('chalk');
const path = require('path');

/**
 * Shows the main menu to select a file.
 * @param {Array<{path: string, name: string, type: string}>} files
 * @returns {Promise<object>} Selected file object
 */
async function showMainMenu(files) {
    if (files.length === 0) {
        console.log(chalk.yellow('No LaTeX or Typst files found in the workspace.'));
        return null;
    }

    const cwd = process.cwd();

    const choices = files.map(f => {
        // Calculate relative path from CWD
        let relPath = path.relative(cwd, f.path);

        // Format: Filename [Type] - RelativePath
        return {
            name: `${chalk.bold(f.name)} ${chalk.cyan(`[${f.type}]`)}  ${chalk.gray(relPath)}`,
            value: f
        };
    });

    const { selectedFile } = await inquirer.prompt([
        {
            type: 'list',
            name: 'selectedFile',
            message: 'Select a document to compile:',
            choices: choices,
            pageSize: 15
        }
    ]);

    return selectedFile;
}

/**
 * Shows compilation options.
 * @returns {Promise<object>} Selected options
 */
async function showCompilationOptions() {
    const { options } = await inquirer.prompt([
        {
            type: 'checkbox',
            name: 'options',
            message: 'Compilation Options:',
            choices: [
                { name: 'Watch Mode (Auto-recompile on change)', value: 'watch' },
                { name: 'Clean Build (Remove aux files)', value: 'clean' }
            ]
        }
    ]);

    return {
        watch: options.includes('watch'),
        clean: options.includes('clean')
    };
}

module.exports = { showMainMenu, showCompilationOptions };
