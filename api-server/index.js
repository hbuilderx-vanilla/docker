/**
 * @author flymyd
 */
const Koa = require('koa');
const bodyParser = require('koa-bodyparser');
const { build } = require('./build');
const { buildV2 } = require('./buildV2');
const { packageDist } = require('./packageDist');

const LISTEN_PORT = 3000;
const app = new Koa();
app.use(bodyParser());

app.use(async (ctx, next) => {
    if (ctx.path === '/') {
        ctx.body = `HbuilderX-Vanilla api server is running at ${LISTEN_PORT}`;
    }
    await next();
});

app.use(async (ctx, next) => {
    if (ctx.path === '/build') {
        const query = ctx.request.query;
        if (query.project) {
            let buildResult;
            if (query.vueVersion == "2") {
                buildResult = await buildV2(query.project).catch(e => e);
            } else {
                buildResult = await build(query.project).catch(e => e);
            }
            if (buildResult) {
                const packageResult = await packageDist(query.project).catch(e => e);
                ctx.body = packageResult;
            } else ctx.body = false;
        } else {
            ctx.body = 'Need params: {project: string}';
        }
    }
    await next();
});

// app.use(async (ctx, next) => {
//     if (ctx.path === '/post') {
//         console.log('Request Body:', ctx.request.body);
//         ctx.body = ctx.request.body;
//     }
//     await next();
// });

app.listen(LISTEN_PORT, () => {
    console.log(`HbuilderX-Vanilla api server start successfully at ${new Date()}.`);
});