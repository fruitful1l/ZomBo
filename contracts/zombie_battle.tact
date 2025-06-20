import "./zombie_survive.tact";
import "./zombie_player";

contract ZombieBattle {
    receive(){}
    
   
    receive(msg: GoOut){
        
        let enemy = zombieGenerator("MozgoEd");
        if(msg.damage+msg.weapon.damage >= enemy._dna%100) {
            emit("yaaay".asComment());
        } else {
            emit("noooo".asComment());
        }
        
    }














}