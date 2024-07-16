
// Import the cds facade object (https://cap.cloud.sap/docs/node.js/cds-facade)
const cds = require('@sap/cds')

// The service implementation with all service handlers
module.exports = cds.service.impl(async function() {

    const { Risks, Item, BusinessPartners } = this.entities;

    this.before("addItem", (req)=>{
        if(req.data.quantity>100)

        return req.error(400, "Quantity must be less than 100")
    })

    this.on("addItem", ({data:{descr, title, quantity}})=>{
        cds.db.run(INSERT ({descr: `${descr}`, title: `${title}`, quantity: `${quantity}`}) .into (Item))
        
    })

    this.on("getItemsByQuantity", async ({data:{quantity}})=>{
        return await cds.db.run(SELECT.from (Item) .where `quantity = ${quantity}`)
    })

    this.on("hello", ({data})=>{
        return "HELLO"
    })

    
  });