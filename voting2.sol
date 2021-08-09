pragma solidity 0.8.6;
contract Vote {
    address owner;
    enum VoteTypes { Notvoted, Yes, No }
    mapping (address => VoteTypes) public votes;
    address[] public voters;
    string public question;
    modifier onlyOwner() {require(msg.sender == owner); _;}
    
    constructor(string memory _question) public{
        question = _question;
        owner=msg.sender;
        votes[0x0000000000000000000000000000000000000000]=VoteTypes.Notvoted;
    }
    
    function voteYes() public returns (bool success) {
        if(!addressInArray(msg.sender)){voters.push(msg.sender);}
        votes[msg.sender] = VoteTypes.Yes;
        return true;
    }
    
    function voteNo() public returns (bool sucess) {
        if(!addressInArray(msg.sender)){voters.push(msg.sender);}
        votes[msg.sender] = VoteTypes.No;
        return true;
    }
    
    function removeVote() public {
        require (addressInArray(msg.sender)); 
        votes[msg.sender] = VoteTypes.Notvoted;
        for(uint i=0; i<voters.length; i++){
         if(voters[i] == msg.sender){
            voters[i] = 0x0000000000000000000000000000000000000000;
            }
        }
    }
    
    function results() public view returns (uint yesVotes, uint noVotes){
        
    }
    
     function getVoters() public view returns(address[] memory) {
    return voters;
    }
    
    
    function addressInArray(address inAddress) private view returns (bool inArray) {
        for(uint i=0; i<voters.length; i++){
            if(voters[i] == inAddress){
                return true;
            }else{
                return false;
            }
        }
    }
    
        function destroy() public {
        selfdestruct(payable(msg.sender));
    }
    
}


