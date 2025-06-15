// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0;
import "./lookAround.sol";


contract ZombieWeapons is LookAround{
    struct Weapon {
        string name;
        uint dna;
    }
    mapping (uint => address) WeaponToOwner;
    mapping (address => uint) OwnerWeaponCount;
    

    Weapon[] public weapons;
    

    event WeaponFound(address playerId, string name, uint weaponProperties);

    function _weapongenerator() internal view returns(uint) {
        uint weaponProperties = uint(keccak256(abi.encodePacked(block.timestamp))) % (10**9);
        
        return(weaponProperties);
    }

    function _obtainWeapon(address _playerId,string memory _name) internal{

        uint weaponProperties = _weapongenerator();
        weapons.push(Weapon(_name, weaponProperties));
        uint id = weapons.length - 1;
        WeaponToOwner[id] = _playerId;
        OwnerWeaponCount[_playerId]++;

    }


}