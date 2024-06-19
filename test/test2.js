const { exec } = require("child_process");
const { promisify } = require("util");
const path = require("path");
const os = require("os");
const fs = require("fs");

const execAsync = promisify(exec);

const test = async () => {
    try {
        const HBUILDER_DIR = '/opt/core';
        const UNI_INPUT_DIR = path.join('/projects', 'test3');
        const VITE_ROOT_DIR = UNI_INPUT_DIR;
        const UNI_HBUILDERX_PLUGINS = path.join(HBUILDER_DIR, 'plugins');
        const UNI_CLI_CONTEXT = path.join(UNI_HBUILDERX_PLUGINS, 'uniapp-cli');
        const UNI_NPM_DIR = path.join(UNI_HBUILDERX_PLUGINS, 'npm');
        const UNI_NODE_DIR = path.join(UNI_HBUILDERX_PLUGINS, 'node');
        const NODE_ENV = 'production';
        const NODE = 'node';
        const UNI_CLI = path.join(UNI_CLI_CONTEXT, 'bin', 'uniapp-cli.js');
        const PATH_ADDONS = process.env.PATH + `;${UNI_INPUT_DIR}/node_modules/.bin;`;
        const UNI_PLATFORM = "mp-weixin" // app-plus/h5/mp-weixin/mp-baidu/mp-alipay
        const UNI_OUTPUT_DIR = path.join(UNI_INPUT_DIR, 'unpackage', 'dist', 'build', UNI_PLATFORM)
        const UNI_APP_PRODUCTION_TYPE = "LOCAL_PACKAGING"
        const VUE_CLI_TRANSPILE_BABEL_RUNTIME = "true"
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
            UNI_OUTPUT_DIR,
            UNI_PLATFORM,
            UNI_APP_PRODUCTION_TYPE,
            VUE_CLI_TRANSPILE_BABEL_RUNTIME,
            PATH: PATH_ADDONS,
        };
        process.chdir(UNI_CLI_CONTEXT);
        //const buildCommand = `"${NODE}" --max-old-space-size=2048 --no-warnings "${UNI_CLI}" build --platform h5 --outDir ${path.join(UNI_INPUT_DIR, 'wgt-dist')}`;
        const buildCommand = `"${NODE}" --max-old-space-size=2048 --no-warnings "${UNI_CLI}"`;
        // clean dist
        fs.rm(UNI_OUTPUT_DIR, { recursive: true, force: true }, function (error) {
            if (error) {
                console.log(error);
                return false;
            }
        });
        const { stdout, stderr } = await execAsync(buildCommand, { env: { ...childEnv } });
        console.log('stdout:', stdout);
        console.error('stderr:', stderr);
    } catch (error) {
        console.error('Error during build:', error);
    }
}

test()