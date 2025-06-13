// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./lookAround.sol";


contract ZombieWeapons is LookAround{
    struct Weapon {
        uint8 range;
        uint8 damage;
        uint8 durability;
    }
    mapping (uint => address) WeaponToOwner;
    mapping (address => uint) OwnerWeaponCount;

    Weapon[] public weapons;

    event WeaponFound(address playerId, string name, uint weaponProperties);

    uint RandNonce = 0;
    function _weapongenerator(string memory _name) internal returns(uint) {
        uint weaponProperties = uint(keccak256(abi.encodePacked(block.timestamp, RandNonce, _name))) % (10**9);
        RandNonce++;
        return(weaponProperties);
    }

    function _obtainWeapon(address _playerId,string memory _name) internal{
        
        uint weaponProperties = _weapongenerator(_name);
        uint range = weaponProperties/1000000;
        uint damage = weaponProperties / 1000 % 1000;
        uint durability = weaponProperties % 1000;
        weapons.push(Weapon(uint8(range), uint8(damage), uint8(durability)));
        uint id = weapons.length;
        WeaponToOwner[id] = _playerId;
        OwnerWeaponCount[_playerId] ++;
        emit WeaponFound(_playerId, _name, weaponProperties);

    }


}