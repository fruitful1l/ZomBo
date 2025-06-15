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
        bool busy;
        Class class;
        Weapon weapon;
    }

    mapping (uint => address) IdToUser;
    mapping (address => uint) OwnerToId;
    mapping (address => uint) OwnerIdCount;

    event PlayerCreated(uint id, string name, string classType);
    event Victory(string result, uint enemy, uint player);
    event Players(Player[] players);

    Player[] public players;
    function createPlayer(string memory _name, uint _class) external {

        if (_class == 1) {
            players.push(Player(_name,100,100,1,true,false,Class(100,100,100,100), Weapon('fist',101010101)));
            uint id = uint(players.length) - 1;
            IdToUser[id] = msg.sender;
            OwnerToId[msg.sender] = id; 
            OwnerIdCount[msg.sender] ++;
           

        } else {
            players.push(Player(_name,100,100,1,true,false,Class(80,80,80,80), Weapon('fist',555555555)));
            uint id = uint(players.length - 1);
            IdToUser[id] = msg.sender;
            OwnerToId[msg.sender] = id;
            OwnerIdCount[msg.sender] ++;
          
        }
        emit Players(players);
    }

    function findWeapon(string memory _name) external{
        uint result = _rolldice(1000, OwnerToId[msg.sender]);
        address player = msg.sender;
        if(result >= 100) {
            _obtainWeapon(player, _name);
        }
    }

    function getWeaponsByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](OwnerWeaponCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < weapons.length; i++) {
      if (WeaponToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
    }

    function changeWeapon(uint id) external {
        require(msg.sender == WeaponToOwner[id]);

        players[OwnerToId[msg.sender]].weapon = weapons[id];
    }
    
    function TakeALook() external{
        
        uint playerId = OwnerToId[msg.sender];
        uint result = _getRoll(playerId);
        if(result == 1) {
            players[playerId].busy = true;
            Player memory player = players[playerId];
            Zombie memory enemy = _zombieGen(playerId);
            if (enemy.health <= (player.class.damage + player.weapon.dna%100)) {
                emit Victory("Victory!!!", (player.class.damage + player.weapon.dna%100),enemy.health);
                players[playerId].level++;
        }

            else{
                emit Victory("Lose!", (player.class.damage + player.weapon.dna%100),enemy.health);
                players[playerId].alive = false;
            }


            
            

        }   else {
            emit Victory("Nothing was found", 0, players[playerId].class.damage);
        }
    }


}

