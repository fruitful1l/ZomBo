// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./zombieWeapons.sol";

contract ZombieSurvive is ZombieWeapons {
    struct Class {
        uint32 energy;
        uint32 weight;
        uint32 damage;
        uint8 health;
    }
    
    struct Player {
        string name;
        uint8 hunger;
        uint8 water;
        uint32 level;
        bool alive;
        Class class;
    }

    mapping (uint => address) IdToUser;
    mapping (address => uint) OwnerToId

    

    Player[] public players;
    function createPlayer(string memory _name, string memory _class) external {
        if (keccak256(abi.encodePacked(_class)) == keccak256(abi.encodePacked("melee"))) {
            players.push(Player(_name,100,100,1,true,Class(100,100,100,100)));
            uint id = players.length;
            IdToUser[id] = msg.sender;

        } else {
            players.push(Player(_name,100,100,1,true,Class(80,80,80,80)));
            uint id = players.length;
            IdToUser[id] = msg.sender;
        }
    }

    function findWeapon(uint _playerId, string _name) external{
        uint modulus = 100;
        uint success = 80;
        uint result = _rolldice(modulus, _playerid)

        if(result <= success) {
            _obtainWeapon(_playerId, _name);
        }
    }


}

