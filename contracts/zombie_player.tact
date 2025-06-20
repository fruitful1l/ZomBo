message Heal {
    hp: Int;
}

struct Weapon {
    name: String;
    range: Int;
    damage: Int;
}

message GoOut {
    id: Int as uint128;
    hp: Int;
    damage: Int;
    weapon: Weapon;
}


struct Player {
    energy: Int as uint32;
    health: Int as uint32;
    damage: Int as uint32;
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
            energy: 1000,
            health: 100,
            damage: 100,
            weapon: Weapon{
                name: "fist",
                range: 10,
                damage: 10
            }     
        }
    }

    receive(){}


    get fun getHealth(): Int {
        return self.playerHero.health;
    }

    receive(msg: GoOut) {
        message(MessageParameters {
            to: self.master,
            value: ton("0.005"),
            body: GoOut {
                id: self.playerId,
                hp: self.playerHero.health,
                damage: self.playerHero.damage,
                weapon: self.playerHero.weapon
            }.toCell(),
            

        });
    }



    receive(msg: Heal) {
        require(self.owner == sender(), "nono");
        require(self.playerHero.health + msg.hp <= 110, "overheal");
        require(self.playerHero.energy > 100, "not enough energy");
        self.playerHero.health += msg.hp;
        self.playerHero.energy -= 100;
        
    }



    







}