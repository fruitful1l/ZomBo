import "./zombie_battle.tact";

message Heal {
    hp: Int;
}

struct Weapon {
    name: String;
    range: Int;
    damage: Int;
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
    busy: Bool = false;

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

    receive("GoOut") {
        deploy(DeployParameters {
            init: initOf ZombieBattle((self.playerHero.damage+self.playerHero.weapon.damage), self.playerHero.weapon.range, self.playerHero.energy, self.playerHero.health, myAddress()), // initial code and data
            mode: SendIgnoreErrors, // skip the message in case of errors
            value: ton("0.05"),
            
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