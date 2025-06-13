const ZombieSurvive = artifacts.require("ZombieSurvive");

 contract("ZombieSurvive", (accounts) => {
   let[alice,bob] = accounts;
   

   it("should be able to create a new player", async() => {
        const contractInstance = await ZombieSurvive.new();
        const result = await contractInstance.createPlayer("Monster", "melee", {from: alice});
        assert.equal(result.receipt.status, true);
        const secondresult = await contractInstance.createPlayer("MEGA ZOMBIE KILLER", "alien", {from: bob});
        assert.equal(secondresult.logs[0].args.id.toString(), "1");

 
   })

   it("should pick the weapon", async() => {
        const contractInstance = await ZombieSurvive.new();
        const result = await contractInstance.findWeapon("mama", {from: alice});
        assert.equal(result.receipt.status, true);
   })

   it("should fight the Zombie", async() => {
        const contractInstance = await ZombieSurvive.new();
        await contractInstance.createPlayer("Monster", "melee", {from: alice});
        const result = await contractInstance.TakeALook({from: alice});
        assert.equal(result.receipt.status, true);


        console.log("=======================================")
        console.log(result.logs[0].args.enemy.toString());
        console.log(result.logs[0].args.player.toString());
        console.log(result.logs[0].args.result);
        console.log("=======================================")
    })

    it("should change weapon and the damage", async() => {
        const contractInstance = await ZombieSurvive.new();
        await contractInstance.createPlayer("Monster", "melee", {from: alice});
        await contractInstance.findWeapon("knife", {from: alice});
        await contractInstance.changeWeapon(0, {from:alice});
        const result = await contractInstance.TakeALook({from: alice}) 
        assert.equal(result.receipt.status, true);
        console.log("=======================================")
        console.log(result.logs[0].args.enemy.toString());
        console.log(result.logs[0].args.player.toString());
        console.log(result.logs[0].args.result);
        console.log("=======================================")

 
    })

   


 })

