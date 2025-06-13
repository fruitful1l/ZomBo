// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./zombieRollDice.sol";

contract LookAround is ZombieRollDice {
    struct Zombie {
        string name;
        uint damage;
        uint health;
    }
    function _getRoll(uint _playerId) internal view returns(uint) {
        uint result = _rolldice(1000, _playerId);


        if (result >=1) {
            return(1);
        } else {
            return(0);
        }
    }

    function _zombieGen(uint _playerId) internal view returns(Zombie memory){
        
        uint zombieDNA = uint(keccak256(abi.encodePacked(block.timestamp,_playerId)))% (10**4);

        return Zombie("Bob", zombieDNA/100, zombieDNA %100);

    }
}