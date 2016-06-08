
contract IPOI {

  struct Idea {
    uint id;
    address owner;
    address[] parties;
    uint256 date;
    string description;
    bytes proofDoc;
  }

  //Declares a state variable 'numIdeaId'
  uint numIdeaId;
  //Creates a mapping of Idea datatypes
  mapping(uint => Idea) ideas;

  // Owner
  address public owner;
  
  // Fee to use the service
  uint public fee;

  //Set owner and fee
  function IPOI(uint feeParam) {
    owner = msg.sender;
    fee = feeParam;
  }
  
  function changeContractFee(uint newFee) onlyowner {
    fee =  newFee;
  }

  // Create initial idea contract
  function createIdea(address ideaOwner, address[] partiesEntry, string descriptionEntry) onlyowner returns(uint ideaId) {

    if (msg.value >= fee) {

      if (msg.value > fee) {
        msg.sender.send(msg.value - fee); //payed more than required => refund
      }

      ideaId = numIdeaId++;
      Idea idea = ideas[ideaId];
      idea.id = ideaId;
      idea.owner = ideaOwner;

      for (uint i = 0; i < partiesEntry.length; i++) {
        idea.parties.push(partiesEntry[i]); 
      }

      idea.date = now;
      idea.description = descriptionEntry;

      IdeaChangeEvent(idea.date, "IPOI Contract Creation", descriptionEntry);
    }
  }
  
  /* Wrong
  function getIdeasForOwner(address owner) returns(uint[] ideaRet) {
      uint[] storage ideaReturn;
      for(uint i=0;i<=numIdeaId;i++) {
          if(ideas[numIdeaId].owner == owner)
            ideaReturn.push(ideas[numIdeaId].id);
      }
    return ideaReturn;
  }
  */
   
  function getIdeaDate(uint ideaId) returns(uint ideaDate) {
    return ideas[ideaId].date;
  }
  
  function getIdeaDescription(uint ideaId) returns(string ideaDescription) {
    return ideas[ideaId].description;
  }

  function getIdeaParties(uint ideaId) returns(address[] ideaParties) {
    return ideas[ideaId].parties;
  }
  
  function getOwner() returns(address owner) {
    return owner;
  }
  

  // Upload documentation for proof of idea (signed signatures?)
  function ideaProofDocument(bytes IPOIProofHash, uint ideaId) onlyowner {
    ideas[ideaId].proofDoc = IPOIProofHash;
    IdeaChangeEvent(block.timestamp, "Entered Idea Proof Document", "Idea proof in IPFS");
  }


  // Declare event structure
  event IdeaChangeEvent(uint256 date, string indexed name, string indexed description);

  function destroy() {
    if (msg.sender == owner) {
      suicide(owner); // send any funds to owner
    }
  }
  
  modifier onlyowner() {
    if (msg.sender == owner)
      _
  }

  // This function gets executed if a transaction with invalid data is sent to
  // the contract or just ether without data. We revert the send so that no-one
  // accidentally loses money when using the contract.
  function() {
    throw;
  }
}
