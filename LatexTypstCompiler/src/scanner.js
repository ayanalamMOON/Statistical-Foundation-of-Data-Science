const { glob } = require('glob');
const path = require('path');

/**
 * Scans the workspace for LaTeX and Typst files.
 * @param {string} rootDir - The root directory to scan.
 * @returns {Promise<Array<{path: string, name: string, type: 'latex' | 'typst'}>>}
 */
async function scanWorkspace(rootDir) {
    const pattern = '**/*.{tex,typ}';
    const options = {
        cwd: rootDir,
        ignore: ['**/node_modules/**'],
        absolute: true,
    };

    try {
        // glob v10 returns a promise directly
        const files = await glob(pattern, options);

        const result = files.map((file) => {
            // In v10, file paths might be returned with forward slashes even on Windows,
            // which is fine, but let's normalize if needed.
            // Actually glob usually returns what matches.

            const ext = path.extname(file).toLowerCase();
            return {
                path: file,
                name: path.basename(file),
                type: ext === '.tex' ? 'latex' : 'typst',
            };
        });

        return result;
    } catch (err) {
        throw err;
    }
}

module.exports = { scanWorkspace };
