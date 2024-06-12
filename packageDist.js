const os = require("os");
const path = require("path");
const archiver = require('archiver');
const { createWriteStream, copyFileSync } = require("fs");
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
    const timeStamp = new Date().getTime()
    const systemTempFolderPath = os.tmpdir();
    const zipPath = path.join(systemTempFolderPath, `${projectName}-${timeStamp}.zip`)
    const wgtPath = path.join(distPath, `${projectName}-${timeStamp}.wgt`)
    return new Promise((resolve, reject) => {
        zipDirectory(distPath, zipPath)
            .then(() => copyFileSync(zipPath, wgtPath))
            .then(() => resolve(`${projectName}-${timeStamp}.wgt`))
            .catch(err => {
                console.error('An error occurred:', err)
                reject(false)
            });
    })
}