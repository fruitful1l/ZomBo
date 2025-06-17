import "./zombie_player.tact";
import "@stdlib/deploy";

struct Zombie {
    _dna: Int;
    _name: String;
}

message NewPlayer {
    
}

message FindWeapon {
    name: String;
}



fun zombieGenerator(_name: String): Zombie {
    let dna = rollDice(1000000,9999999);
    return Zombie {
        _name: _name,
        _dna: dna, 
    }
}



fun rollDice(_modulus_min: Int, _modulus: Int): Int{
    let rand = random(_modulus_min, _modulus);
    return(rand % _modulus);
}

fun generateWeapon(_name: String): Weapon {
    let weaponAttributes = rollDice(10^4, 10^5);
    return Weapon{name: _name, range: weaponAttributes/100, damage: weaponAttributes%100}
}


contract ZombieSurvive {
    receive() {
        cashback(sender());
    }
    ownerToId: map<Address,Int as uint128> = emptyMap();
    id: Int as uint32 = 0;
    weaponId: Int as uint256 = 0;
    ownerWeaponCount: map<Address,Int as uint128> = emptyMap();
    weaponToOwner: map<Int as uint128, Address> = emptyMap();

    receive(msg: NewPlayer) {
        deploy(DeployParameters {
            init: initOf ZombiePlayer(self.id, sender(), myAddress()),
            value: ton("0.5")
        });
        
        self.ownerToId.set(sender(), self.id);
        self.id += 1;
    }

    receive("heal") {
        send(SendParameters{ // this will forward excess gas
            to: contractAddress(initOf ZombiePlayer(self.ownerToId.get(sender())!!, sender(), myAddress())),
            body: Heal{hp: 10}.toCell(),
            value: 0, 
            mode: SendRemainingValue + SendIgnoreErrors 
        });

        
    }












    // receive(msg: FindWeapon) {
    //     require(self.OwnerWeaponCount.get(sender()) == 0, "Not enough hands!");

    //     newWeapon: Weapon = generateWeapon(msg.name);
    //     //Function For Weapon Contract Deployment
    //     self.weaponToOwner.set(self.weaponId, sender());
    
    // }



    








}
