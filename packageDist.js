const os = require("os");
const path = require("path");
const archiver = require('archiver');
const { promisify } = require("util");
const { createWriteStream } = require("fs");
const fs = require("fs");

const zipDirectory = (source, out) => {
    const archive = archiver('zip', { zlib: { level: 9 } });
    const stream = createWriteStream(out);
    return new Promise((resolve, reject) => {
        archive
            .directory(source, false)
            .on('error', err => {
                console.error(err)
                reject(0)
            })
            .pipe(stream);
        stream.on('close', () => resolve(1));
        archive.finalize();
    });
};

/**
 * 压缩并重命名wgt包
 * @param projectName 仓库名
 */
exports.packageDist = (projectName) => {
    const distPath = path.join('/projects', projectName, 'wgt-dist')
    const renameAsync = promisify(fs.rename);
    const timeStamp = new Date().getTime()
    const systemTempFolderPath = os.tmpdir();
    const workPath = path.join(systemTempFolderPath, `${projectName}-dist`)
    const zipPath = path.join(systemTempFolderPath, `${projectName}-${timeStamp}.zip`)
    const wgtPath = path.join(distPath, `${projectName}-${timeStamp}.wgt`)
    return new Promise((resolve, reject) => {
        zipDirectory(workPath, zipPath)
            .then(() => renameAsync(zipPath, wgtPath))
            .then(() => resolve(`${projectName}-${timeStamp}.wgt`))
            .catch(err => {
                console.error('An error occurred:', err)
                reject(false)
            });
    })
}