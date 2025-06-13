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
    mapping (address => uint) OwnerToId;
    mapping (address => uint) OwnerIdCount;

    event PlayerCreated(uint id, string name, string classType);
    event Victory(string result);
    event Players(Player[] players);

    Player[] public players;
    function createPlayer(string memory _name, string memory _class) external {

        if (keccak256(abi.encodePacked(_class)) == keccak256(abi.encodePacked("melee"))) {
            players.push(Player(_name,100,100,1,true,Class(100,100,100,100)));
            uint id = uint(players.length) - 1;
            IdToUser[id] = msg.sender;
            OwnerToId[msg.sender] = id; 
            OwnerIdCount[msg.sender] ++;
            emit PlayerCreated(id, _name, _class);

        } else {
            players.push(Player(_name,100,100,1,true,Class(80,80,80,80)));
            uint id = uint(players.length - 1);
            IdToUser[id] = msg.sender;
            OwnerToId[msg.sender] = id;
            OwnerIdCount[msg.sender] ++;
            emit PlayerCreated(id, _name, _class);
        }
        emit Players(players);
    }

    function findWeapon(string memory _name) external{
        uint modulus = 100;
        uint success = 80;
        uint result = _rolldice(modulus, OwnerToId[msg.sender]);

        address player = msg.sender;
        if(result <= success) {
            _obtainWeapon(player, _name);
        }
    }
    
    event Test(uint enemy);
    function TakeALook() external{
        
        uint playerId = OwnerToId[msg.sender];
        uint result = _getRoll(playerId);
        if(result == 1) {
            
            Zombie memory enemy = _zombieGen(playerId);
             
            
            if (enemy.health < players[playerId].class.damage) {
                emit Victory("Zombie defeated!");
            }
            else {
                emit Victory("Zombie has won!");
            }

        } else {
            emit Victory("Nothing was found");
        }
    }


}

