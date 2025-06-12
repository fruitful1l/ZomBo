const ZombieSurvive = artifacts.require("ZombieSurvive");

 contract("ZombieSurvive", (accounts) => {
   let[alice,bob] = accounts;
   it("should be able to create a new player", async() => {
        const contractInstance = await ZombieSurvive.new();
        const result = await contractInstance.createPlayer("ZoV", "melee", {from: alice});
        assert.equal(result.receipt.status, true);
        const secondresult = await contractInstance.createPlayer("GOYDA", "alien", {from: bob});
        assert.equal(secondresult.logs[0].args.id.toString(), "2");
   })
 })

