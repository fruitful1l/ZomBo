import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { ZombieSurvive } from '../build/ZombieSurvive/ZombieSurvive_ZombieSurvive';
import '@ton/test-utils';

describe('ZombieSurvive', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let zombieSurvive: SandboxContract<ZombieSurvive>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        zombieSurvive = blockchain.openContract(await ZombieSurvive.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await zombieSurvive.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            null,
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: zombieSurvive.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {

    });

    it('should increase counter', async () => {
    
    
    });

             

          
});
