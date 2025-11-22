const execa = require('execa');
const path = require('path');
const fs = require('fs');

/**
 * Compiles a LaTeX file.
 * @param {string} filePath - Path to the .tex file.
 * @param {object} options - Compilation options.
 * @returns {Promise<object>} - Result of the compilation.
 */
async function compileLatex(filePath, options = {}) {
    const dir = path.dirname(filePath);
    const fileName = path.basename(filePath);

    // Create a separate build directory if requested, but standard practice
    // often keeps aux files next to source or in a specific build folder.
    // For this advanced system, let's try to keep it clean if possible,
    // but pdflatex often defaults to current dir.

    try {
        const { stdout, stderr } = await execa('pdflatex', [
            '-interaction=nonstopmode',
            '-file-line-error',
            fileName
        ], {
            cwd: dir,
        });
        return { success: true, output: stdout };
    } catch (error) {
        return { success: false, output: error.stdout || error.message, error: error };
    }
}

/**
 * Compiles a Typst file.
 * @param {string} filePath - Path to the .typ file.
 * @param {object} options - Compilation options.
 * @returns {Promise<object>} - Result of the compilation.
 */
async function compileTypst(filePath, options = {}) {
    const dir = path.dirname(filePath);

    try {
        const { stdout, stderr } = await execa('typst', [
            'compile',
            filePath
        ], {
            cwd: dir,
        });
        return { success: true, output: stdout || stderr };
    } catch (error) {
        return { success: false, output: error.stderr || error.message, error: error };
    }
}

module.exports = { compileLatex, compileTypst };
