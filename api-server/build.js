/**
 * @author flymyd
 */
const { exec } = require("child_process");
const { promisify } = require("util");
const path = require("path");
const os = require("os");

exports.build = (projectName) => {
    const execAsync = promisify(exec);
    const systemTempFolderPath = os.tmpdir();
    return new Promise(async (resolve, reject) => {
        try {
            const HBUILDER_DIR = '/opt/core';
            const UNI_INPUT_DIR = path.join('/projects', projectName);
            const VITE_ROOT_DIR = UNI_INPUT_DIR;
            const UNI_HBUILDERX_PLUGINS = path.join(HBUILDER_DIR, 'plugins');
            const UNI_CLI_CONTEXT = path.join(UNI_HBUILDERX_PLUGINS, 'uniapp-cli-vite');
            const UNI_NPM_DIR = path.join(UNI_HBUILDERX_PLUGINS, 'npm');
            const UNI_NODE_DIR = path.join(UNI_HBUILDERX_PLUGINS, 'node');
            const NODE_ENV = 'production';
            const NODE = 'node';
            const UNI_CLI = path.join(UNI_CLI_CONTEXT, 'node_modules', '@dcloudio', 'vite-plugin-uni', 'bin', 'uni.js');
            const PATH_ADDONS = process.env.PATH + `;${UNI_INPUT_DIR}/node_modules/.bin;`;
            const childEnv = {
                ...process.env,
                HBUILDER_DIR,
                UNI_INPUT_DIR,
                VITE_ROOT_DIR,
                UNI_CLI_CONTEXT,
                UNI_HBUILDERX_PLUGINS,
                UNI_NPM_DIR,
                UNI_NODE_DIR,
                NODE_ENV,
                NODE,
                PATH: PATH_ADDONS,
            };
            process.chdir(UNI_CLI_CONTEXT);
            const buildCommand = `"${NODE}" --max-old-space-size=2048 --no-warnings "${UNI_CLI}" build --platform app --outDir ${path.join(UNI_INPUT_DIR, 'wgt-dist')}`;
            const { stdout, stderr } = await execAsync(buildCommand, { env: { ...childEnv } });
            // console.log('stdout:', stdout);
            console.error('stderr:', stderr);
            resolve(true);
        } catch (error) {
            console.error('Error during build:', error);
            reject(false);
        }
    });
};