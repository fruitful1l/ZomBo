import "./zombie_player.tact";
import "@stdlib/ownable";


message NewPlayer {
    battleaddr: Address;
}

message FindWeapon {
    name: String;
}

fun rollDice(_modulus_min: Int, _modulus: Int): Int{
    let rand = random(_modulus_min, _modulus);
    return(rand % _modulus);
}


struct Zombie {
    _dna: Int;
    _name: String;
}

fun zombieGenerator(_name: String): Zombie {
    let dna = rollDice(1000000,9999999);
    return Zombie {
        _name: _name,
        _dna: dna, 
    }
}






fun generateWeapon(_name: String): Weapon {
    let weaponAttributes = rollDice(10^4, 10^5);
    return Weapon{name: _name, range: weaponAttributes/100, damage: weaponAttributes%100}
}



contract ZombieSurvive with Ownable {

    owner: Address = address("EQCObIMiCLlWlEdT9FVPZWz5jAWocxqhu6bYzwtJzEkkhAsa");
    
    receive() {
    }
    ownerToId: map<Address,Int as uint128> = emptyMap();
    id: Int as uint32 = 0;
    weaponId: Int as uint256 = 0;
    ownerWeaponCount: map<Address,Int as uint128> = emptyMap();
    weaponToOwner: map<Int as uint128, Address> = emptyMap();

    receive(msg: NewPlayer) {
        deploy(DeployParameters {
            // bounce is set to true by default
            init: initOf ZombiePlayer(self.id, sender(), myAddress()), // initial code and data
            mode: SendIgnoreErrors, // skip the message in case of errors
            value: ton("1"), // a whole Toncoin

        });
        
        self.ownerToId.set(sender(), self.id);
        self.id += 1;
    }



    
    
    
    
    
    
    
    
    

  
    
    









    get fun getBalance(): Int {
        return myBalance();
    }

    













    








}
