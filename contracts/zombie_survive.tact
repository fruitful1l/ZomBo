struct Weapon {
    name: String;
    range: Int;
    damage: Int;
}

struct Player {
    name: String;
    health: Int;
    damage: Int;
    weapon: Weapon;
    }

message NewPlayer {
    name: String;
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
    receive() {}

    receive(msg: NewPlayer) {
        

    }
    








}
