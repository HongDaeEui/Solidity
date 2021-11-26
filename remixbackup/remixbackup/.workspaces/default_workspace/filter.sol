pragma solidity 0.8.4;

contract filter {


    string myStructArray = ["a", "b", "c"];
    bool[] checker;

    function checkArray() public returns(bool[]) {
    
        for(uint i = 0; i<3 i++) {
            if(myStructArray[i] == "a"){
                checker[i]=true; 
            }
            else{
                checker[i]=false;
            }
        }
        return checker;
    }
}