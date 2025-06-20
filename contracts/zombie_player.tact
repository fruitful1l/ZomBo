message Heal {
    hp: Int;
}

struct Weapon {
    name: String;
    range: Int;
    damage: Int;
}


struct Player {
    health: Int;
    damage: Int;
    weapon: Weapon;
    }

contract ZombiePlayer  {
    playerId: Int;
    master: Address;
    playerHero: Player;
    owner: Address;
    init(_id: Int, owner: Address, master:Address){
        self.master = master;
        self.playerId = _id;
        self.owner = owner;


        self.playerHero = Player{
            health: 100,
            damage: 100,
            weapon: Weapon{
                name: "fist",
                range: 10,
                damage: 10
            }     
        }
    }

    receive(){

    }


    get fun getHealth(): Int {
        return self.playerHero.health;
    }

    receive(msg: Heal) {
        self.playerHero.health += msg.hp;
    }
    







}