import "./zombie_survive.tact";
import "./zombie_player";

contract ZombieBattle {
    dmg: Int;
    rng: Int;
    enrj: Int;
    hps: Int;
    player: Address;
    init(_dmg: Int, _rng: Int, _enrj: Int, _hps: Int, player: Address) {
        self.dmg = _dmg;
        self.rng = _rng;
        self.enrj = _enrj;
        self.hps = _hps;
        self.player = player;
    }
    
    
    
    
    receive(){}
    
   
    receive("start"){
        require(sender() == self.player, "Not the one fighting");
        let enemy = zombieGenerator("MozgoEd");
    
        
    }














}