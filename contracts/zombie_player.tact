import "./zombie_survive.tact";

contract ZombiePlayer {
    playerId: Int;
    playerHero: Player;
    owner: Address;
    init(_id: Int, player: Player, owner: Address){
        self.playerId = _id;
        self.playerHero = player;
        self.owner = owner;
    }



}