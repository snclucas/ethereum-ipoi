contract IPOI {

  struct Party {
    address addr;
  }

  struct Idea {
    /* Array of parties involved in the idea */
    mapping(uint => Party) parties;
    /* Date stamp */
    uint256 date;
    /* Idea description */
    bytes32 description;
    /* Digital document hash */
    bytes proofDoc;
  }
  
  //Declares a state variable 'numCampaigns'
  uint numIdeaId;
  //Creates a mapping of Campaign datatypes
  mapping(uint => Idea) ideas;
  
  // Owner
  address public owner;



  //Set Owner
  function IPOI() {
    owner = msg.sender;
  }

  modifier onlyowner() {
    if (msg.sender == owner)
      _
  }

  // Create initial idea contract
  function createIdea(address[] partiesEntry, bytes32 descriptionEntry) onlyowner returns (uint ideaId) {
    ideaId = numIdeaId++; 
    Idea idea = ideas[ideaId]; 
        
    for (uint i = 0; i < partiesEntry.length; i++) {
      idea.parties[i].addr = partiesEntry[i];
    }

    idea.date = now;
    idea.description = descriptionEntry;
    bytes32 name = "IPOI Contract Creation";

    majorEventFunc(idea.date, name, descriptionEntry);
  }

  function getOwner() returns(address owner) {
    return owner;
  }


  // Upload documentation for proof of idea (signed signatures?)
  function ideaProofDocument(bytes IPOIProofHash, uint ideaId) onlyowner {
    ideas[ideaId].proofDoc = IPOIProofHash;
    majorEventFunc(block.timestamp, "Entered Idea Proof Document", "Idea proof in IPFS");
  }

  // Log major life events
  function majorEventFunc(uint256 eventTimeStamp, bytes32 name, bytes32 description) {
    MajorEvent(block.timestamp, eventTimeStamp, name, description);
  }

  // Declare event structure
  event MajorEvent(uint256 logTimeStamp, uint256 eventTimeStamp, bytes32 indexed name, bytes32 indexed description);

  function destroy() {
    if (msg.sender == owner) {
      suicide(owner); // send any funds to owner
    }
  }

  // This function gets executed if a transaction with invalid data is sent to
  // the contract or just ether without data. We revert the send so that no-one
  // accidentally loses money when using the contract.
  function() {
    throw;
  }
}

