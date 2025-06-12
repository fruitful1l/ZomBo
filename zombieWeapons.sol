// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./ownable.sol";

contract ZombieWeapons is Ownable{
    struct Weapon {
        uint8 range;
        uint8 damage;
        uint8 durability;
    }
    mapping (uint => address) WeaponToOwner;
    mapping (address => uint) OwnerWeaponCount;

    Weapon[] public weapons;

    uint RandNonce = 0;
    function _weapongenerator(string memory _name) internal returns(uint) {
        uint weaponProperties = uint(keccak256(abi.encodePacked(block.timestamp, RandNonce, _name))) % (10**9);
        RandNonce++;
        return(weaponProperties);
    }

    function obtainWeapon(address _playerId,string memory _name) external{
        require(OwnerWeaponCount[msg.sender] == 0 || OwnerWeaponCount[msg.sender] == 1);
        uint weaponProperties = _weapongenerator(_name);
        uint range = weaponProperties/1000000;
        uint damage = weaponProperties / 1000 % 1000;
        uint durability = weaponProperties % 1000;
        weapons.push(Weapon(uint8(range), uint8(damage), uint8(durability)));
        uint id = weapons.length;
        WeaponToOwner[id] = _playerId;

    }


}