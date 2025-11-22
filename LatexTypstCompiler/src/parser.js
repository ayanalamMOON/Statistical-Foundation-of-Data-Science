/**
 * Parses LaTeX log output to find errors.
 * @param {string} logContent - The content of the LaTeX log or stdout.
 * @returns {Array<{line: string, message: string, file: string}>}
 */
function parseLatexLog(logContent) {
    const errors = [];
    // Regex to capture file:line:error style messages
    // Example: ./file.tex:10: Undefined control sequence.
    const regex = /^(.*):(\d+):\s+(.*)$/gm;

    let match;
    while ((match = regex.exec(logContent)) !== null) {
        errors.push({
            file: match[1],
            line: match[2],
            message: match[3],
        });
    }

    // Also look for "!" error lines which are common in LaTeX logs
    // Example: ! Undefined control sequence.
    // This is harder to map to a line number without context, but we can capture it.
    const bangRegex = /^!\s+(.*)$/gm;
    while ((match = bangRegex.exec(logContent)) !== null) {
        // Avoid duplicates if captured by the first regex
        if (!errors.some(e => e.message.includes(match[1]))) {
            errors.push({
                file: 'Unknown',
                line: '?',
                message: match[1]
            });
        }
    }

    return errors;
}

/**
 * Parses Typst error output.
 * @param {string} output - The stderr/stdout from Typst.
 * @returns {Array<{line: string, message: string, file: string}>}
 */
function parseTypstOutput(output) {
    const errors = [];
    // Typst error format:
    // error: something went wrong
    //    ┌─ file.typ:10:1

    // We can look for "error:" and try to extract context.
    // Simple regex for now:
    const regex = /error:\s+(.*)/g;
    const locationRegex = /┌─\s+(.*):(\d+):(\d+)/g;

    let match;
    while ((match = regex.exec(output)) !== null) {
        errors.push({
            message: match[1],
            file: '?',
            line: '?'
        });
    }

    // Try to match locations to the last error?
    // This is a bit tricky with simple regex, but let's try to just capture locations.
    // A more robust parser would iterate lines.

    return errors;
}

module.exports = { parseLatexLog, parseTypstOutput };
