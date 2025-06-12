// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./ownable.sol";

contract ZombieRollDice is Ownable {
    function _rolldice(uint _modulus, uint _playerid) internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, _playerid))) % _modulus;
    }
}