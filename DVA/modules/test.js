var db = require('../db');

async function test() {
    await require('../models').sequelize.sync();
    var clusterId = await db.addCluster('hello');
    var aspectId = await db.addAspect('hello', 'boy', 0.0);
    console.log(clusterId, aspectId);
}
test();


